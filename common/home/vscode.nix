{ pkgs, inputs, ... }:

let
  vscode-marketplace = inputs.nix-vscode-extensions.extensions.${inputs.arch}.vscode-marketplace;
  vscode-settings = import ./vscode-settings.nix;

  keybindings = import ./vscode-keybindings.nix { };
in
{
  inherit keybindings;

  enable = true;
  extensions =
    with pkgs.vscode-extensions;
    [
      bbenoist.nix
      dracula-theme.theme-dracula
      vscodevim.vim
    ]
    ++ (with vscode-marketplace; [
      github.copilot
      github.copilot-chat
      golang.go
      jakebecker.elixir-ls
      jamesottaway.nix-develop
      ms-python.python
      nomicfoundation.hardhat-solidity
      phoenixframework.phoenix
      rust-lang.rust-analyzer
      shopify.ruby-extensions-pack
      sourcegraph.cody-ai
    ]);

  mutableExtensionsDir = true;
  userSettings = vscode-settings;
}
