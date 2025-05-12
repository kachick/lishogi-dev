{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShellNoCC {
            buildInputs = (
              with pkgs;
              [
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
              ]
            );
          };
        }
      );
      packages.lila = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.mkShell {
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
        }
      );
    };
}
