{ config, pkgs, ... }:
let
  username = config.myConfig.username;
in
{

  homebrew = {
    casks = [ "aerospace" ];
    taps = [ "nikitabobko/tap" ];
  };

  home-manager.users.${username}.xdg.configFile = {
    "aerospace/aerospace.toml".source = pkgs.substituteAll {
      src = ./aerospace.toml;
      sketchybar = "${pkgs.sketchybar}/bin/sketchybar";
    };
  };
}
