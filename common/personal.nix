{ config, pkgs, ... }:

let
  username = config.myConfig.username;
in
{

  homebrew = {
    casks = [
      "epic-games"
      "moonlight"
      "retroarch"
      "setapp"
      "steam"
      "vagrant"
      "vagrant-vmware-utility"
      "vmware-fusion"
    ];
  };

  environment.systemPackages = [
    pkgs.colima
    pkgs.docker
    pkgs.packer
  ];

}
