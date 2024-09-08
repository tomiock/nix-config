{ outputs, inputs, config, lib, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = { 
          family = "Hack Nerd Font"; 
          style = "Regular"; 
        };
      };

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
          blue = "#70e5ff";
          cyan = "#95fcda";
          green = "#8efad6";
          magenta = "#b04cfc";
          red = "#ff9191";
          yellow = "#f4fca4";
          white = "0x${base06}";
        };

        cursor = {
          cursor = "0x${base02}";
          text = "0x${base05}";
        };

        normal = {
          black = "0x${base01}";
          blue = "0x${aqua}";
          cyan = "0x${turquois}";
          green = "0x${green}";
          magenta = "0x${purple}";
          red = "0x${red}";
          white = "0x${base05}";
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
