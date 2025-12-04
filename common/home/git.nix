{ config, lib, osConfig, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      pull.rebase = "true";
      user = {
        name = osConfig.myConfig.name;
        email = osConfig.myConfig.email;
      };
    };
  };
}
