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
    ./darwin/homebrew
    ./darwin/system.nix
    ./vim
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

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
    (with pkgs; [
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
    nerd-fonts.jetbrains-mono
  ];

  services.emacs = {
    enable = true;
  };

  homebrew = {
    casks = [ "logseq" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;
  home-manager.users.${username} =
    { pkgs, ... }:
    {
      imports = [
        ./home/kitty.nix
      ];

      home.stateVersion = "23.05";

      home.packages =
        (with pkgs; [
          bitwarden-cli
          gh
          htop
          jq
        ])
        ++ (with unstable; [ jetbrains.idea-community ]);

      programs.home-manager.enable = true;

      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

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

        settings = {
          pull.rebase = "true";
          user = {
            name = config.myConfig.name;
            email = config.myConfig.email;
          };
        };
      };

      programs.starship = {
        enable = true;
      };

      programs.zsh = {
        enable = true;

        autosuggestion = {
          enable = true;
        };

        initContent = ''
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
  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
  };

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

}
