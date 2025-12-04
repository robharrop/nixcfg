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
    ./darwin/vim
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
        ./home/direnv.nix
        ./home/eza.nix
        ./home/fzf.nix
        ./home/gh.nix
        ./home/git.nix
        ./home/kitty.nix
        ./home/starship.nix
        ./home/zsh.nix
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
