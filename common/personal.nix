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
      "steam"
      "vagrant"
      "vagrant-vmware-utility"
      "vmware-fusion"
    ];
  };

  home-manager.users.${username} = { pkgs, ... }: {
    programs.git.userEmail = "rob@robharrop.dev";
  };
}
