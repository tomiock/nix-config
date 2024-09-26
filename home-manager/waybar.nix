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
        height = 10;
        position = "top";
        layer = "top";
        mode = "dock";
        gtk-layer-shell = true;
        spacing = 10;
        margin = "5 5 0 5";

        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          #"hyprland/window"
          "clock"
        ];

        modules-right = [
          "tray"
          "backlight"
          "memory"
          "cpu"
          "network"
          "battery"
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
          format-wifi = " ";
          format-ethernet = "󰈁";
          format-disconnected = "";
          tooltip-format = ''
            {essid}
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

.modules-left, .modules-center {
    opacity: 1;
    border-radius: 0.5rem;
    background-color: rgba(0,0,0,0.5);
    padding: 2px;
}

.modules-center {
  color: lavender;
}

.modules-right {
    opacity: 1;
    background-color: rgba(0,0,0,0.5);
    border-radius: 0.5rem;
    padding: 5px 5px 5px 10px;
    color: lavender;
}

window#waybar {
    background: rgba(100, 18, 27, 0);
    color: #cdd6f4;
}

#workspaces button {
    color: dimgrey;
}

#workspaces button.active {
  color: silver;
}

#workspaces button.focused {
    border-radius: 10px;
}

#workspaces button.urgent {
    border-radius: 10px;
    color: crimson;
    background-color: rgba(0,0,0,0.5);
}

#workspaces button:hover {
    border-radius: 10px;
}

#tray {
}

#workspaces {
    border-radius: 10px;
    padding-right: 0px;
    padding-left: 5px;
}

#clock {
    font-weight: bolder;
    border-radius: 0.5rem;
    padding: 0 3px 0 0;
}

#backlight {
    color: #8fbcbb;
}

#battery {
    color: lightgreen;
}

#memory {
    color: lightpink;
}

#disk {
    color: lightskyblue;
}

#cpu {
    color: lightgoldenrodyellow;
}

#temperature {
    color: lightslategray;
}

/* FINAL CSS*/
      '';
  };
}
