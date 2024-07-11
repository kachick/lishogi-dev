{
  inputs = {
    # Candidate channels
    #   - https://discourse.nixos.org/t/differences-between-nix-channels/13998
    # How to update the revision
    #   - `nix flake update --commit-lock-file` # https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake-update.html
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        formatter = pkgs.nixfmt-rfc-style;
        devShells.default =
          with pkgs;
          mkShell {
            buildInputs = [
              # https://github.com/NixOS/nix/issues/730#issuecomment-162323824
              bashInteractive

              # Maintain this repo
              nil
              nixfmt-rfc-style
              dprint
              typos
              go-task
              shellcheck
              shfmt
              hostname
            ];

            shellHook = ''
              echo 'Happy coding! Happy shogi!'
            '';
          };

        packages.lila = pkgs.mkShell {
          buildInputs = with pkgs; [
            bashInteractive

            sbt
            nodejs-18_x
            nodejs-18_x.pkgs.yarn
            python3
          ];

          shellHook = ''
            echo 'Dev shell for "lila"'
          '';
        };
      }
    );
}
