{
  inputs = {
    # Candidate channels
    #   - https://github.com/kachick/anylang-template/issues/17
    #   - https://discourse.nixos.org/t/differences-between-nix-channels/13998
    # How to update the revision
    #   - `nix flake update --commit-lock-file` # https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake-update.html
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs-stable, nixpkgs-unstable, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        stable-pkgs = nixpkgs-stable.legacyPackages.${system};
        unstable-pkgs = nixpkgs-unstable.legacyPackages.${system};
      in
      {
        devShells.default = with stable-pkgs;
          mkShell {
            buildInputs = [
              # https://github.com/NixOS/nix/issues/730#issuecomment-162323824
              # https://github.com/kachick/dotfiles/pull/228
              bashInteractive

              # For development this repo
              unstable-pkgs.nil
              unstable-pkgs.nixpkgs-fmt
              unstable-pkgs.dprint
              unstable-pkgs.typos
              unstable-pkgs.go-task

              # For run lishogi server
              #
              # Do not include mongodb with nixpkgs
              # It is unfree license and cachix does not have binary cache. Building in local is much slow
              # Run mongod container. singularity is a replacement of docker
              singularity
              redis

              # For run Shogi AI
              python3
              python311Packages.requests
              gcc

              # For develop lishogi
              sbt
              nodejs-18_x
              yarn
            ];

            shellHook = ''
              echo 'Happy coding! or shogi!'
            '';
          };

        packages.redis = stable-pkgs.writeShellScriptBin "run_redis" ''
          set -euxo pipefail

          ${stable-pkgs.lib.getBin stable-pkgs.redis}/bin/redis-server
        '';

        packages.mongo = stable-pkgs.writeShellScriptBin "run_mongo" ''
          set -euxo pipefail

          # https://doi-t.hatenablog.com/entry/2013/12/08/161929
          databaseDir=''${1:-"$(${stable-pkgs.lib.getBin stable-pkgs.coreutils}/bin/mktemp -d --suffix=.lishogi.mongo.database)"}
          ${stable-pkgs.lib.getExe stable-pkgs.singularity} run --bind "''${databaseDir}:/data/db" docker://mongo:5.0.24-focal
        '';
      }
    );
}
