{ config, pkgs, lib, inputs, home-manager, ... }:

let
  username = inputs.username;
  unstable = import "${inputs.unstable}" {
    system = inputs.arch;
    config.allowUnfree = true;
  };

  vscode-marketplace = inputs.nix-vscode-extensions.extensions.${inputs.arch}.vscode-marketplace;

in
{

  system = import ./darwin/system.nix { };

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
      helix
      mas
      ripgrep
      vim
    ] ++ [
      unstable.go
    ];

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.zsh.enable = true;

  services.emacs = {
    enable = true;
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

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
      jq
    ] ++ (with unstable; [
      jetbrains.idea-community
    ]);

    programs.home-manager.enable = true;

    programs.eza = {
      enable = true;
      enableZshIntegration = true;
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

      extraConfig = {
        pull.rebase = "true";
      };
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
        github.copilot
        github.copilot-chat
        golang.go
        jakebecker.elixir-ls
        jamesottaway.nix-develop
        nomicfoundation.hardhat-solidity
        phoenixframework.phoenix
      ]);
      mutableExtensionsDir = true;
      userSettings = {
        # 00
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.fontSize" = 14;
        "workbench.colorTheme" = "Dracula";
      };
    };

    programs.zsh = {
      enable = true;

      autosuggestion = {
        enable = true;
      };

      initExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';

      shellAliases = {
        ga = "git add";
        gc = "git commit";
        gl = "git pull";
        gp = "git push";
        gco = "git checkout";
        gst = "git status";

      };

      syntaxHighlighting = {
        enable = true;
      };
    };
  };

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

}
