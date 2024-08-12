{ outputs, inputs, config, lib, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {

      window = {
        opacity = .70;
        padding = {
          x = 5;
          y = 2;
        };
      };

      colors = with config.colorScheme.palette; {
        bright = {
          black = "#4d4d4d";
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
          black = "#110f18";
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
        selection = {
          text = "CellForeground";
          background = "#29263c";
        };
      };
    };
  };
}
