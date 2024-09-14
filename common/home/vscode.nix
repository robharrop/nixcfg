{ pkgs, inputs, ... }:

let
  vscode-marketplace = inputs.nix-vscode-extensions.extensions.${inputs.arch}.vscode-marketplace;
in
{
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
  userSettings = {
    # 00
    "editor.fontFamily" = "JetBrainsMono Nerd Font";
    "editor.fontSize" = 14;
    "workbench.colorTheme" = "Dracula";
  };
}
