{ config, pkgs, lib, inputs, home-manager, ... }:

let
  username = inputs.username;
in
{

  homebrew = {
    casks = [
      "epic-games"
      "logseq"
      "steam"
    ];
  };

  home-manager.users.${username} = { pkgs, ... }: {
    programs.git.userEmail = "rob@robharrop.dev";
  };
}
