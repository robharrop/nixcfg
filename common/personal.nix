{
  config,
  home-manager,
  inputs,
  pkgs,
  ...
}:

let
  username = config.myConfig.username;
in
{

  homebrew = {
    casks = [
      "bitwarden"
      "calibre"
      "cameracontroller"
      "epic-games"
      "firefox"
      "google-chrome"
      "hazel"
      "ledger-wallet"
      "logitech-options"
      "moonlight"
      "mullvad-vpn"
      "r-app"
      "raspberry-pi-imager"
      "raycast"
      "rectangle-pro"
      "remarkable"
      "retroarch"
      "rstudio"
      "setapp"
      "shortcat"
      "steam"
      "vagrant-vmware-utility"
      "vagrant"
      "vmware-fusion"
      "whatsapp"
      "yubico-yubikey-manager"
      "zotero"
    ];

    masApps = {
      "Todoist: To-Do List & Tasks" = 585829637;
      "iA Writer" = 775737590;
      "Grammarly: AI Writing Support" = 1462114288;
    };
  };

  environment.systemPackages = [
    pkgs.colima
    pkgs.docker
    pkgs.packer
  ];
}
