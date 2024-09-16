{
  config,
  lib,
  pkgs,
  ...
}:
let
  homebrewPrefix = config.homebrew.brewPrefix;
  username = config.myConfig.username;
  pluginsDir = ./plugins;
  itemsDir = ./items;
in
{
  config = {
    homebrew = {
      brews = [ "switchaudio-osx" ];
      casks = [ "sf-symbols" ];
    };

    home-manager.users.${username}.xdg.configFile =
      lib.mapAttrs' (
        name: _: lib.nameValuePair "sketchybar/plugins/${name}" { source = "${pluginsDir}/${name}"; }
      ) (builtins.readDir pluginsDir)
      // lib.mapAttrs' (
        name: _: lib.nameValuePair "sketchybar/items/${name}" { source = "${itemsDir}/${name}"; }
      ) (builtins.readDir itemsDir)
      // {
        "sketchybar/colours.sh" = {
          source = ./colours.sh;
        };
        "sketchybar/icons.sh" = {
          source = ./icons.sh;
        };
      };

    services.sketchybar = {
      # read config from file
      config = ''
        #!/usr/bin/env bash

        source "''${HOME}/.config/sketchybar/colours.sh" 
        source "''${HOME}/.config/sketchybar/icons.sh" 

        FONT="JetBrainsMono Nerd Font"
        PADDING="0"

        ITEM_DIR="''${HOME}/.config/sketchybar/items" # Directory where the items are configured
        PLUGIN_DIR="''${HOME}/.config/sketchybar/plugins" # Directory where all the plugin scripts are stored

        # Setting up the general bar appearance of the bar
        bar=(
          height=36
          color=$DRACULA_BACKGROUND
          shadow=off
          position=top
          sticky=on
          padding_right=10
          padding_left=10
          corner_radius=9
          y_offset=10
          margin=10
          blur_radius=20
          notch_width=188
        )

        sketchybar --bar "''${bar[@]}"

        # Item defaults
        defaults=(
          updates=on
          icon.font="$FONT:Bold:14.0"
          icon.color=$DRACULA_FOREGROUND
          icon.padding_left=$PADDING
          icon.padding_right=$PADDING
          label.font="$FONT:Semibold:13.0"
          label.color=$DRACULA_FOREGROUND
          label.padding_left=$PADDING
          label.padding_right=$PADDING
          padding_right=$PADDING
          padding_left=$PADDING
          background.corner_radius=0
          popup.background.border_width=2
          popup.background.corner_radius=9
          popup.background.border_color=$DRACULA_FOREGROUND
          popup.background.color=$DRACULA_BACKGROUND
          popup.blur_radius=20
          popup.background.shadow.drawing=on
          slider.knob.font="$FONT:Bold:14.0"
        )

        sketchybar --default "''${defaults[@]}"

        source ''${ITEM_DIR}/clock.sh
        source ''${ITEM_DIR}/battery.sh
        source ''${ITEM_DIR}/volume.sh
        source ''${ITEM_DIR}/status.sh

        sketchybar --update
      '';

      enable = true;

      extraPackages = [ pkgs.jq ];
    };
  };
}
