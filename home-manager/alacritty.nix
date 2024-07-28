{ outputs, inputs, config, lib, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      /*
      colors.primary = {
        background = "#000000";
        foreground = "#edecee";
        colors.cursor.cursor = "970fff";
      };


      colors.selection = {
        text = "CellForeground";
        background = "#29263c";
      };

      colors.normal = {
        black = "#110f18";
        red = "#ff6767";
        green = "#61ffca";
        yellow = "#ffca85";
        blue = "#970fff";
        magenta = "#970fff";
        cyan = "#61ffca";
        white = "#edecee";
      };

      colors.bright = {
        black = "#4d4d4d";
        red = "#ff6767";
        green = "#61ffca";
        yellow = "#ffca85";
        blue = "#a277ff";
        magenta = "#a277ff";
        cyan = "#61ffca";
        white = "#edecee";
      };
      */

      window.padding = {
        x = 5;
        y = 2;
      };

      colors = with config.colorScheme.palette; {
        bright = {
          black = "0x${base00}";
          blue = "0x${aqua}";
          cyan = "0x${turquois}";
          green = "0x${green}";
          magenta = "0x${purple}";
          red = "0x${red}";
          white = "0x${base06}";
          yellow = "0x${yellow}";
        };
        cursor = {
          cursor = "0x${base06}";
          text = "0x${base06}";
        };
        normal = {
          black = "0x${base00}";
          blue = "0x${purple}";
          cyan = "0x${turquois}";
          green = "0x${turquois}";
          magenta = "0x${purple}";
          red = "0x${red}";
          white = "0x${base06}";
          yellow = "0x${yellow}";
        };
        primary = {
          background = "0x${base00}";
          foreground = "0x${base06}";
        };
      };
    };
  };
}
