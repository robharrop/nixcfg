{
  description = "Systemm configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    mkAlias = {
      url = "github:reckenrode/mkAlias";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # add the inputs declared above to the argument attribute set
  outputs = inputs @ { self, nixpkgs, home-manager, darwin, flake-utils, ... }:

    flake-utils.lib.eachSystem [ "aarch64-darwin" "x86_64-linux" ]
      (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        {
          formatter = pkgs.nixpkgs-fmt;
        }
      ) // {

      darwinConfigurations."vetinari" =
        let
          arch = "aarch64-darwin";
        in
        darwin.lib.darwinSystem {

          inputs = inputs // { inherit arch; };

          system = arch;
          modules = [ 
            home-manager.darwinModules.home-manager
            ./hosts/vetinari/default.nix 
          ]; 
        };
    };


}
