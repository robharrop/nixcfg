{ config, pkgs, lib, inputs, home-manager, ... }:

let
  username = inputs.username;
in
{

  homebrew = {
    casks = [
      "epic-games"
      "steam"
    ];
  };

  home-manager.users.${username} = { pkgs, ... }: {
    programs.git.userEmail = "rob@robharrop.dev";
  };
}
