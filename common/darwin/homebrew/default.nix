{ config, ... }:
{
  environment.systemPath = [ config.homebrew.brewPrefix ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };
  };
}
