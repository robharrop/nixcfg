{ config, pkgs, lib, inputs, home-manager, ... }:

let
  username = inputs.username;
in
{

  homebrew =
    {
      casks = [
        "chromium"
	"gpg-suite"
        "1password"
	"microsoft-teams"
        "rancher"
	"slack"
        "superhuman"
      ];
    };

  home-manager.users.${username} = { pkgs, ... }: {

    programs.git = {
      userEmail = "rob@bitso.com";

      signing = {
        key = "ACC3A3D8FD118EFB";
        signByDefault = true;
      };
    };

  };
}
