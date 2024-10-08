{
  config,
  pkgs,
  inputs,
  ...
}:

let
  username = config.myConfig.username;
  unstable = import "${inputs.unstable}" {
    system = inputs.arch;
    config.allowUnfree = true;
  };

in
{

  imports = [
    ./darwin/aerospace
    ./darwin/homebrew
    ./darwin/sketchybar
    ./vim
  ];

  system = import ./darwin/system.nix { };

  nixpkgs.config.allowUnfree = true;

  nix = {
    extraOptions = ''
      auto-optimise-store = false
      experimental-features = nix-command flakes
    '';

    optimise.automatic = true;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    (with pkgs;
    [
      emacs
      helix
      mas
      nixfmt-rfc-style
      ripgrep
      magic-wormhole-rs
      vim
    ])
    ++ [ unstable.go ];

  fonts.packages = with pkgs; [
    noto-fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.zsh.enable = true;

  services.emacs = {
    enable = true;
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;
  home-manager.users.robharrop =
    { pkgs, ... }:
    {

      home.stateVersion = "23.05";

      home.packages =
        (with pkgs;
        [
          bitwarden-cli
          gh
          htop
          jq
        ])
        ++ (with unstable; [ jetbrains.idea-community ]);

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

        userName = config.myConfig.name;
        userEmail = config.myConfig.email;

        extraConfig = {
          pull.rebase = "true";
        };
      };

      programs.kitty = import ./home/kitty.nix { };

      programs.starship = {
        enable = true;
      };

      programs.vscode = import ./home/vscode.nix {
        inherit pkgs;
        inherit inputs;
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

  # allow TouchID to authorize sudo
  security.pam.enableSudoTouchIdAuth = true;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

}
