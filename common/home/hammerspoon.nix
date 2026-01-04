{ ... }:
{
  home.file.".hammerspoon/init.lua" = {
    source = ./hammerspoon/init.lua;
    force = true;
  };

  home.file.".hammerspoon/heic-converter.lua" = {
    source = ./hammerspoon/heic-converter.lua;
    force = true;
  };
}
