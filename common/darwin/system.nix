{ ... }:
{
  defaults = {
    dock = {
      autohide = true;
      static-only = true;

      # lock screen in top left corner
      wvous-tl-corner = 13;

      # disable the annoying quick note in the bottem right corner
      wvous-br-corner = 1;
    };

    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 5;
    };

    # use standard function keys
    NSGlobalDomain = {
      "com.apple.keyboard.fnState" = true;

      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 10;
      KeyRepeat = 1;

      # menu bar item spacing
      NSStatusItemSelectionPadding = 8;
      NSStatusItemSpacing = 12;

      # hide the menu bar by default
      _HIHideMenuBar = true;
    };
  };

  keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  stateVersion = 4;
}
