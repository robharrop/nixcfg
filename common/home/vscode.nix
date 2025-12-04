{ pkgs, inputs, osConfig, ... }:

let
  vscode-marketplace = inputs.nix-vscode-extensions.extensions.${inputs.arch}.vscode-marketplace;
  vscode-settings = import ./vscode-settings.nix;
  keybindings = import ./vscode-keybindings.nix;
in
{
  programs.vscode = {
    enable = true;

    mutableExtensionsDir = true;

    profiles.default = {
      inherit keybindings;

      extensions =
        with pkgs.vscode-extensions;
        [
          bbenoist.nix
          dracula-theme.theme-dracula
          vscodevim.vim
        ]
        ++ (with vscode-marketplace; [
          brettm12345.nixfmt-vscode
          golang.go
          jakebecker.elixir-ls
          jamesottaway.nix-develop
          ms-python.python
          nomicfoundation.hardhat-solidity
          phoenixframework.phoenix
          rust-lang.rust-analyzer
          shopify.ruby-extensions-pack
          tamasfe.even-better-toml
        ]);

      userSettings = vscode-settings;
    };
  };
}
