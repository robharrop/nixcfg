{
  description = "Systemm configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nickel.url = "github:tweag/nickel";
    nickel.inputs.nixpkgs.follows = "nixpkgs";

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
    darwin.url = "github:robharrop/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  # add the inputs declared above to the argument attribute set
  outputs =
    inputs@{
      self,
      nixpkgs,
      unstable,
      nickel,
      home-manager,
      nixvim,
      darwin,
      flake-utils,
      ...
    }:

    let
      darwinSystem =
        system: extraModules:
        darwin.lib.darwinSystem {
          inputs = inputs // {
            arch = system;
          };
          inherit system;

          modules = [
            home-manager.darwinModules.home-manager
            nixvim.nixDarwinModules.nixvim
            # add a username option to the valid set of module options
            ./common/shared/options.nix
            ./common/darwin.nix
          ]
          ++ extraModules;
        };

    in
    {
      darwinConfigurations = {
        robharrop-mac = darwinSystem "aarch64-darwin" [ ./common/meta.nix ];
        vetinari = darwinSystem "aarch64-darwin" [ ./common/personal.nix ];
      };

    }
    // flake-utils.lib.eachSystem [ "aarch64-darwin" ] (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        formatter = pkgs.nixfmt-rfc-style;
      }
    );

}
