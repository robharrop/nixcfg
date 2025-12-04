{ ... }:
{
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
}
