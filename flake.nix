{
  description = "Systemm configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nickel.url = "github:tweag/nickel";
    nickel.inputs.nixpkgs.follows = "nixpkgs";

    # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
    darwin.url = "github:robharrop/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    cloudflare-cert = {
      url = "https://developers.cloudflare.com/cloudflare-one/static/Cloudflare_CA.pem";
      flake = false;
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
      darwin,
      flake-utils,
      ...
    }:

    let
      darwinSystem =
        system: extraModules: hostName:
        darwin.lib.darwinSystem {
          inputs = inputs // {
            arch = system;
            username = "robharrop";
          };
          inherit system;
          modules = [
            home-manager.darwinModules.home-manager
            ./common/darwin.nix
            ./hosts/${hostName}/default.nix
          ] ++ extraModules;
        };

      processConfigurations = builtins.mapAttrs (n: v: v n);

    in
    {
      darwinConfigurations = processConfigurations {
        BTSWS0DJQ6LX = darwinSystem "aarch64-darwin" [ ./common/bitso.nix ];
        BTSWS2FPX1L6L = darwinSystem "aarch64-darwin" [ ./common/bitso.nix ];
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
