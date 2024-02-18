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
        stable-pkgs = import nixpkgs-stable {
          system = system;
          # Why: MongoDB is using SSPL even if old major as 4.4. They apply SSPL since all patches since 2018
          #      See https://github.com/mongodb/mongo/blob/89d6ffe6fc67b36fd47aff6425087003966588e3/README#L80-L86
          # How: https://discourse.nixos.org/t/allow-unfree-in-flakes/29904/2
          config.allowUnfree = true;
        };
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
              mongodb
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

            shellHook = "run_db.sh";
          };
      }
    );
}
