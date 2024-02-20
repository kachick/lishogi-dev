{
  inputs = {
    # Candidate channels
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
        devShells.default = with unstable-pkgs;
          mkShell {
            buildInputs = [
              # https://github.com/NixOS/nix/issues/730#issuecomment-162323824
              stable-pkgs.bashInteractive

              # Maintain this repo
              nil
              nixpkgs-fmt
              dprint
              typos
              go-task
              shellcheck
              shfmt
            ];

            shellHook = ''
              echo 'Happy coding! Happy shogi!'
            '';
          };

        packages.lila = stable-pkgs.mkShell
          {
            buildInputs = with stable-pkgs; [
              bashInteractive

              sbt
              nodejs-18_x
              yarn
            ];

            shellHook = ''
              echo 'Dev shell for "lila"'
            '';
          };
      }
    );
}
