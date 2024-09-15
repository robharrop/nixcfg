{ config, ... }:
let
  username = config.myConfig.username;
in
{

  homebrew.casks = [ "aerospace" ];

  home-manager.users.${username}.home.xdg.configFile = {
    "aerospace/aerospace.toml".source = ./aerospace.toml;
  };
}
