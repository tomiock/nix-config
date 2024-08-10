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

  swayCfg = config.wayland.windowManager.sway;
  hyprlandCfg = config.wayland.windowManager.hyprland;
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
        position = "bottom";
        layer = "top";
        modules-left =
          ["custom/menu"]
          ++ (lib.optionals swayCfg.enable [
            "sway/workspaces"
            "sway/mode"
          ])
          ++ (lib.optionals hyprlandCfg.enable [
            "hyprland/workspaces"
            "hyprland/submap"
          ]);

        modules-center = [
          "cpu"
          "memory"
          "clock"
          "battery"
        ];

        modules-right = [
          "network"
          "pulseaudio"
          "tray"
        ];

        clock = {
          interval = 1;
          format = "{:%d/%m %H:%M:%S}";
          format-alt = "{:%Y-%m-%d %H:%M:%S %z}";
          on-click-left = "mode";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };

        cpu = {
          format = "  {usage}%";
        };
        memory = {
          format = "  {}%";
          interval = 5;
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
        "sway/window" = {
          max-length = 20;
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
          font-family: Arial, Courier New;
          font-size: 12pt;
          padding: 0;
          margin: 0 0.4em;
        }

        window#waybar {
          padding: 0;
          border-radius: 0.5em;
          background-color: rgba(50, 50, 50, 0.7); /* semi-transparent dark gray */
          color: #FFFFFF; /* white */
        }

        .modules-left {
          margin-left: -0.65em;
        }

        .modules-right {
          margin-right: -0.65em;
        }

        #workspaces button {
          background-color: #323232; /* dark gray */
          color: #FFFFFF; /* white */
          padding-left: 0.1em;
          padding-right: 0.1em;
          margin-left: 0.1em;
          margin-right: 0.1em;
          margin-top: 0.15em;
          margin-bottom: 0.15em;
        }

        #workspaces button.hidden {
          background-color: #323232; /* dark gray */
          color: #A0A0A0; /* light gray */
        }
        
        #workspaces button.focused,
        #workspaces button.active {
          background-color: #171717; /* dark gray */
          color: #FFFFFF; /* white */
        }

        #clock {
          padding-right: 1em;
          padding-left: 1em;
          border-radius: 0.5em;
        }

        #custom-menu {
          background-color: #2C2C2C; /* darker gray */
          color: #1E90FF; /* dodger blue */
          padding-right: 1.5em;
          padding-left: 1em;
          margin-right: 0;
          border-radius: 0.5em;
        }

        #custom-menu.fullscreen {
          background-color: #1E90FF; /* dodger blue */
          color: #FFFFFF; /* white */
        }

        #custom-hostname {
          background-color: #2C2C2C; /* darker gray */
          color: #1E90FF; /* dodger blue */
          padding-right: 1em;
          padding-left: 1em;
          margin-left: 0;
          border-radius: 0.5em;
        }

        #custom-currentplayer {
          padding-right: 0;
        }

        #tray {
          color: #FFFFFF; /* white */
        }

        #custom-gpu, #cpu, #memory {
          margin-left: 0.05em;
          margin-right: 0.55em;
        }
  '';

  };
}
