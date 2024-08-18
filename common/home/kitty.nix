{ ... }: {
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
}
