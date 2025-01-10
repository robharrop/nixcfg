{ config, ... }:
{
  environment.systemPath = [ config.homebrew.brewPrefix ];

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
    ];

    masApps = {
      "Todoist: To-Do List & Tasks" = 585829637;
      "iA Writer" = 775737590;
      "Grammarly: AI Writing Support" = 1462114288;
    };
  };
}
