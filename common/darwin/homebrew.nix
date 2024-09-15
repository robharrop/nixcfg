{ config, lib, ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };

    casks = [
      "bitwarden"
      "calibre"
      "cameracontroller"
      "google-chrome"
      "firefox"
      "kindle"
      "ledger-live"
      "logitech-options"
      "logseq"
      "mullvadvpn"
      "r"
      "raspberry-pi-imager"
      "raycast"
      "remarkable"
      "rstudio"
      "shortcat"
      "whatsapp"
      "zotero"
    ] ++ lib.lists.flatten config.myConfig.homebrew.extraCasks;

    masApps = {
      "Todoist: To-Do List & Tasks" = 585829637;
      "iA Writer" = 775737590;
    };
  };
}
