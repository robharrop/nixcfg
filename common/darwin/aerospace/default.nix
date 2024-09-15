{ config, ... }:
let
  username = config.myConfig.username;
in
{

  homebrew.casks = [ "nikitabobko/tap/aerospace" ];

  home-manager.users.${username}.xdg.configFile = {
    "aerospace/aerospace.toml".source = ./aerospace.toml;
  };
}
