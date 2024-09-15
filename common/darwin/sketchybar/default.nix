{ config, ... }:
let
  username = config.myConfig.username;
in
{
  config = {
    home-manager.users.${username}.xdg.configFile."sketchybar/plugins/battery.sh".source = ./plugins/battery.sh;

    services.sketchybar = {
      config = ''
        FONT_FACE="JetBrainsMono Nerd Font"

        PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

        sketchybar --bar position=top height=40 blur_radius=0 color=0xFF282A36

        sketchybar --default \
            background.color=0xFF282A36 \
            background.corner_radius=0 \
            background.padding_right=0 \
            background.height=26 \
            icon.font="$FONT_FACE:Medium:15.0" \
            icon.padding_left=5 \
            icon.padding_right=5 \
            label.font="$FONT_FACE:Medium:12.0" \
            label.color=0xffcad3f5 \
            label.y_offset=0 \
            label.padding_left=0 \
            label.padding_right=5

        sketchybar --add item battery right \
            --set battery \
            update_freq=20 \
            script="$PLUGIN_DIR/battery.sh"

            sketchybar --update
      '';
      enable = true;
    };
  };
}
