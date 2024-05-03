{ config, pkgs, lib, inputs, home-manager, ... }:

let
  username = inputs.username;
in
{

  environment.systemPackages = [
    pkgs.colima
    pkgs.docker
    pkgs.packer
  ];

  homebrew = {
    casks = [
      "epic-games"
      "moonlight"
      "setapp"
      "steam"
      "vagrant"
      "vagrant-vmware-utility"
      "vmware-fusion"
    ];

    masApps = {
      "iA Writer" = 775737590;
    };
  };

  home-manager.users.${username} = { pkgs, ... }: {
    programs.git.userEmail = "rob@robharrop.dev";
  };
}
