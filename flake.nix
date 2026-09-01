{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";
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
                nixd
                dprint
                typos
                go-task
                shellcheck
                shfmt
                hostname
              ]
            );
          };

          lila = pkgs.mkShell {
            buildInputs = with pkgs; [
              bashInteractive

              sbt
              nodejs
              nodejs.pkgs.yarn
              python3
            ];

            shellHook = ''
              echo 'Dev shell for "lila"'
            '';
          };
        }
      );
    };
}
