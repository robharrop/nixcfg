{ config, ... }:
{
  programs.zsh = {
    enable = true;

    autosuggestion = {
      enable = true;
    };

    sessionVariables = {
      SSH_AUTH_SOCK = "${config.home.homeDirectory}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
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
}
