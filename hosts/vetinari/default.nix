{ config, pkgs, lib, inputs, home-manager, ... }:

let
  username = "robharrop";
  vscode-marketplace = inputs.nix-vscode-extensions.extensions.${inputs.arch}.vscode-marketplace;
in
{

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    with pkgs;[
      emacs
      git
      mas
      vim
      obsidian
      raycast
      bitwarden-cli

    ];

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.zsh.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  system.defaults = {
    dock.autohide = true;
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
    ];

    masApps = {
      "Todoist: To-Do List & Tasks" = 585829637;
    };
  };

home-manager.useGlobalPkgs = true;
home-manager.useUserPackages = false;
home-manager.users.robharrop = { pkgs, ... }: {

  home.stateVersion = "23.05"; 

  programs.home-manager.enable = true;

  programs.exa = {
    enable = true;
    enableAliases = true;  
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.kitty = {
    enable = true;
    environment = {
      "LS_COLORS" = "1";
    };
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
    ]);
    userSettings = {
      "workbench.colorTheme" =  "Dracula";
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
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
