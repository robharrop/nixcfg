{ config, ... }:
let
  username = config.myConfig.username;
in
{

  homebrew = {
    casks = [ "aerospace" ];
    taps = [ "nikitabobko/tap" ];
  };

  home-manager.users.${username}.xdg.configFile = {
    "aerospace/aerospace.toml".source = ./aerospace.toml;
  };
}
