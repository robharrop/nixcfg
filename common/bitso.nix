{ config, pkgs, lib, inputs, home-manager, ... }:

let
  username = inputs.username;
  vscode-marketplace = inputs.nix-vscode-extensions.extensions.${inputs.arch}.vscode-marketplace;
in
{

  homebrew =
    {
      casks = [
        "chromium"
        "1password"
        "rancher"
        "superhuman"
      ];
    };

  home-manager.users.${username} = { pkgs, ... }: {

    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        dracula-theme.theme-dracula
        vscodevim.vim
      ] ++ (with vscode-marketplace; [
        golang.go
        jakebecker.elixir-ls
        jamesottaway.nix-develop
        phoenixframework.phoenix
      ]);
      userSettings = {
        "workbench.colorTheme" = "Dracula";
      };
    };

    programs.git = {
      userEmail = "rob@bitso.com";

      signing = {
        key = "ACC3A3D8FD118EFB";
        signByDefault = true;
      };
    };

  };
}
