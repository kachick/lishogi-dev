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

  outputs = { self, lib, nixpkgs-stable, nixpkgs-unstable, flake-utils }:
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
              echo 'Welcome this console to run or develop lishogi!'
              echo 'How to use'
              echo '1. Open your 2 terminal windows'
              echo '2. In terminal A: `nix run kachick:nix-flake-lishogi#database`'
              echo '3. In terminal B: `cd nix-flake-lishogi && direnv allow`'
              echo '4. After this, you can run commands in terminal B that written in lilla setup documents'
              echo 'ui/build'
              echo './lila'
            '';
          };

        # packages.database = stable-pkgs.stdenv.mkDerivation
        #   {
        #     name = "database";
        #     src = self;
        #     # https://discourse.nixos.org/t/adding-runtime-dependency-to-flake/27785
        #     buildInputs = with stable-pkgs; [
        #       makeWrapper
        #     ];
        #     installPhase = ''
        #       mkdir -p $out/bin
        #       cp ./run_db.bash $out
        #       install -t $out/bin run_db.bash
        #       makeWrapper run_db.bash $out/bin/database \
        #         --prefix PATH : ${stable-pkgs.lib.makeBinPath [ stable-pkgs.singularity ]}
        #     '';
        #     runtimeDependencies = [
        #       stable-pkgs.singularity
        #     ];
        #   };

        packages.database = stable-pkgs.writeShellScriptBin "run_db" ''
          set -euxo pipefail

          databaseDir="$1"

          echo "''${databaseDir="$(${lib.getBin stable-pkgs.coreutils}/bin/mktemp -d --suffix=.lishogi.mongo.database)"}"
          ${lib.getExe stable-pkgs.singularity} run --bind "''${databaseDir}:/data/db" docker://mongo:5.0.24-focal
        '';
      }
    );
}
