{ config, pkgs, ... }:

let
  username = config.myConfig.username;
in
{

  environment.systemPackages = [
    pkgs.colima
    pkgs.docker
    pkgs.packer
  ];

  homebrew = import ./darwin/homebrew.nix {
    extraCasks = [
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

}
