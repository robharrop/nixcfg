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

  imports = [
    ./darwin/aerospace
    ./darwin/sketchybar
  ];

  homebrew = {
    casks = [
      "bitwarden"
      "calibre"
      "cameracontroller"
      "epic-games"
      "firefox"
      "google-chrome"
      "ledger-live"
      "logitech-options"
      "moonlight"
      "mullvadvpn"
      "r"
      "raspberry-pi-imager"
      "raycast"
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

  home-manager.users.${username} = {
    programs.vscode = import ./home/vscode.nix {
      inherit pkgs;
      inherit inputs;
    };
  };
}
