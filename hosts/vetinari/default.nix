{ config, pkgs, lib, inputs, home-manager, ... }:

let
  username = "robharrop";
  vscode-marketplace = inputs.nix-vscode-extensions.extensions.${inputs.arch}.vscode-marketplace;
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
      obsidian
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

      # lock screen in top left corner
      wvous-tl-corner = 5;
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
      "1password"
      "whatsapp"
      "chromium"
      "steam"
      "epic-games"
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
      htop
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
      enable = true;
    };
    programs.git = {
      enable = true;

      userName = "Rob Harrop";
      userEmail = "rob@robharrop.dev";
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

    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        dracula-theme.theme-dracula
        vscodevim.vim
      ] ++ (with vscode-marketplace; [
        golang.go
        jakebecker.elixir-ls
        jamesottaway.nix-develop
        phoenixframework.phoenix
      ]);
      userSettings = {
        "workbench.colorTheme" = "Dracula";
      };
    };

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;

      shellAliases = {
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gco = "git checkout";
        gst = "git status";

      };
    };
  };

  users.users.robharrop = {
    name = "robharrop";
    home = "/Users/robharrop";
  };
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
