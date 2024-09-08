{
outputs,
config,
lib,
pkgs,
inputs,
...
}: let
  commonDeps = with pkgs; [coreutils gnugrep systemd];
  mkScript = {
    name ? "script",
    deps ? [],
    script ? "",
    }:
    lib.getExe (pkgs.writeShellApplication {
      inherit name;
      text = script;
      runtimeInputs = commonDeps ++ deps;
    });
in {
  # Let it try to start a few more times
  systemd.user.services.waybar = {
    Unit.StartLimitBurst = 30;
  };
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or []) ++ ["-Dexperimental=true"];
    });
    systemd.enable = true;

    settings = {
      primary = {

        exclusive = true;
        height = 40;
        position = "top";
        layer = "top";
        mode = "dock";
        gtk-layer-shell = true;

        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          #"hyprland/window"
          "clock"
        ];

        modules-right = [
          "tray"
          "memory"
          "cpu"
          "network"
          "battery"
          "backlight"
          "pulseaudio"
        ];

        clock = {
          interval = 1;
          rotate = 0;
          format = "{:%d/%m %H:%M:%S}";
          format-alt = "{:%d/%m/%Y %H:%M:%S %z}";
          on-click-left = "mode";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };

        cpu = {
          format = "  {usage}%";
          interval = 10;
          format-alt = "{icon0}{icon1}{icon2}{icon3}";
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
        };

        memory = {
          format = "  {}%";
          interval = 8;
        };

        pulseaudio = {
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭 0%";
          format = "{icon} {volume}% {format_source}";
          format-muted = "󰸈 0% {format_source}";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = lib.getExe pkgs.pavucontrol;
        };

        backlight = {
          device = "intel_backlight";
            format = "{icon} {percent}%";
            format-icons = ["󰃞" "󰃟" "󰃠"];
            on-scroll-up = "brightnessctl set 1%+";
            on-scroll-down = "brightnessctl set 1%-";
            min-length = 6;
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };

        battery = {
          bat = "BAT1";
          interval = 10;
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          onclick = "";
        };

        "hyprland/workspaces" = {
          disable-scroll= true;
          all-outputs= true;
          on-click= "activate";
        };

        network = {
          interval = 3;
          format-wifi = "   {essid}";
          format-ethernet = "󰈁 Connected";
          format-disconnected = "";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
          on-click = mkScript { script = ''ip -o route get to 8.8.8.8 | sed -n "s/.*src \([0-9.]\+\).*/\1/p"| wl-copy''; };
        };

      };
    };
    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left
    style =
      ''
* {
    border: none;
    border-radius: 0;
    font-family: Hack Nerd Font, monospace;
    font-weight: bold;
    font-size: 14px;
    min-height: 0;
}

window#waybar {
    background: rgba(100, 18, 27, 0);
    color: #cdd6f4;
}

#workspaces button {
    padding: 5px;
    color: rgba(151, 15, 255, 1);
    margin-right: 5px;
}

/* green number workspace there the cursor is */
#workspaces button.active {
    color: rgba(97, 255, 202, 1);
}

#workspaces button.focused {
    color: rgba(151, 15, 255, 1);
    border-radius: 10px;
}

#workspaces button.urgent {
    color: #11111b;
    background: #a6e3a1;
    border-radius: 10px;
}

#workspaces button:hover {
    background: #cdd6f4;
    color: #11111b;
    border-radius: 10px;
}

#window,
#clock,
#battery,
#pulseaudio,
#network,
#cpu,
#memory,
#workspaces,
#tray,
#backlight {
    padding: 0px 10px;
    margin: 3px 0px;
    margin-top: 5px;
    background: rgba(10, 10, 10, .5);
}

#backlight {
    border-radius: 10px 0px 0px 10px;
}

#tray {
    border-radius: 10px;
    margin-right: 10px;
}

#workspaces {
    border-radius: 10px;
    margin-left: 10px;
    padding-right: 0px;
    padding-left: 5px;
}

#cpu {
    border-radius: 0px 10px 10px 0px;
    margin-right: 10px;
}

#memory {
    border-radius: 10px 0px 0px 10px;
}

#window {
    border-radius: 10px;
    margin-left: 60px;
    margin-right: 60px;
}

#clock {
    border-radius: 10px 10px 10px 10px;
    margin-left: 5px;
    border-right: 0px;
}

#network {
    border-radius: 10px 0px 0px 10px;

}

#pulseaudio {
    border-left: 0px;
    border-right: 0px;
    border-radius: 0px 10px 10px 0px;
    margin-right: 10px;
}

#pulseaudio.microphone {
    border-radius: 0px 10px 10px 0px;
    border-left: 0px;
    border-right: 0px;
    margin-right: 5px;
}

#battery {
    border-radius: 0px 10px 10px 0px;
    margin-right: 10px;
}
      '';

  };
}
