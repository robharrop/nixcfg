{ config, pkgs, lib, inputs, home-manager, ... }:

let
  username = inputs.username;
  unstable = import "${inputs.unstable}" {
    system = inputs.arch;
    config.allowUnfree = true;
  };
in
{

  nixpkgs.config.allowUnfree = true;

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '';

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    with pkgs;[
      emacs
      mas
      vim
    ] ++ [ unstable.raycast ];

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.zsh.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  system.defaults = {
    dock = {
      autohide = true;
      static-only = true;

      # lock screen in top left corner
      wvous-tl-corner = 13;
    };

    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 5;
    };

    # use standard function keys
    NSGlobalDomain."com.apple.keyboard.fnState" = true;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };


  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };

    casks = [
      "bitwarden"
      "firefox"
      "logseq"
      "whatsapp"
    ];

    masApps = {
      "Todoist: To-Do List & Tasks" = 585829637;
    };
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;
  home-manager.users.robharrop = { pkgs, ... }: {

    home.stateVersion = "23.05";

    home.packages = with pkgs; [
      bitwarden-cli
      gh 
      htop
      jetbrains.idea-community
      jq
    ];

    programs.home-manager.enable = true;

    programs.exa = {
      enable = true;
      enableAliases = true;
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.gh = {
      # see https://github.com/nix-community/home-manager/issues/3401
      enable = false;
    };

    programs.git = {
      enable = true;

      userName = "Rob Harrop";
    };

    programs.kitty = {
      enable = true;
      environment = {
        "LS_COLORS" = "1";
      };
      extraConfig = ''
        map cmd+1 goto_tab 1
        map cmd+2 goto_tab 2
        map cmd+3 goto_tab 3
        map cmd+4 goto_tab 4
        map cmd+5 goto_tab 5
        map cmd+6 goto_tab 6
        map cmd+7 goto_tab 7
        map cmd+8 goto_tab 8
        map cmd+9 goto_tab 9
      '';
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 14;
      };
      settings = {
        macos_option_as_alt = "yes";
        macos_titlebar_color = "#282a36";
      };
      theme = "Dracula";
    };

    programs.starship = {
      enable = true;
    };

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;

      initExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';

      shellAliases = {
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gco = "git checkout";
        gst = "git status";

      };
    };
  };

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
