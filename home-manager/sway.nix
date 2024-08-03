{ pkgs, inputs, outputs, lib, config, ... }:
let rootPath = ../.;
in
{

  home.packages = [
    pkgs.networkmanagerapplet
    pkgs.brightnessctl
    pkgs.swaybg
    (pkgs.writeShellScriptBin "start_sway"
    ''
      #!/usr/bin/env bash

        nm-applet --indicator &

        #swaybg --image "/home/tominix/Pictures/Tokyo_Pink.png" --mode fill &

        mako &
    '')
  ];

  wayland.windowManager.sway = {
      enable = true;

      config = {
        # Set variablessway
        modifier = "Mod4";
        terminal = "\${pkgs.alacritty}/bin/alacritty";
        menu = "\${pkgs.dmenu}/bin/dmenu_path | \${pkgs.dmenu}/bin/dmenu | \${pkgs.findutils}/bin/xargs swaymsg exec --";

        # Input configuration
        input = {
          "1739:52781:SYNA2BA6:00_06CB:CE2D_Touchpad" = {
            dwt = "true";
            tap = "true";
            #natural_scroll = true;
            middle_emulation = "true";
          };
        };

        startup = [
          { command = "bash start_sway"; always = true; }
        ];

        # Keybindings
        keybindings = 
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+Return" = "exec \${pkgs.alacritty}/bin/alacritty";
          "${modifier}+Shift+q" = "kill";
          "${modifier}+d" = "exec $menu";
          "${modifier}+Shift+r" = "reload";
          "${modifier}+Shift+e" = ''exec swaynag -t warning -m "You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session." -B "Yes, exit sway" "swaymsg exit"'';
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";
          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          "${modifier}+Shift+1" = "move container to workspace number 1"; 
          "${modifier}+Shift+2" = "move container to workspace number 2"; 
          "${modifier}+Shift+3" = "move container to workspace number 3"; 
          "${modifier}+Shift+4" = "move container to workspace number 4"; 
          "${modifier}+Shift+5" = "move container to workspace number 5"; 
          "${modifier}+Shift+6" = "move container to workspace number 6"; 
          "${modifier}+Shift+7" = "move container to workspace number 7"; 
          "${modifier}+Shift+8" = "move container to workspace number 8"; 
          "${modifier}+Shift+9" = "move container to workspace number 9"; 
          "${modifier}+Shift+0" = "move container to workspace number 10";

          "${modifier}+b" = "splith";
          "${modifier}+v" = "splitv";
          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";
          "${modifier}+f" = "fullscreen";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";
          "${modifier}+a" = "focus parent";
          "${modifier}+Shift+minus" = "move scratchpad";
          "${modifier}+minus" = "scratchpad show";
          "${modifier}+r" = "mode \"resize\"";      
        };

        # Resize mode
        modes =  {
          resize = {
            Down = "resize grow height 10 px";
            Escape = "mode default";
            Left = "resize shrink width 10 px";
            Return = "mode default";
            Right = "resize grow width 10 px";
            Up = "resize shrink height 10 px";
            h = "resize shrink width 10 px";
            j = "resize grow height 10 px";
            k = "resize shrink height 10 px";
            l = "resize grow width 10 px";
          };
        };

        # Colors
        colors = {
          focused = {
            background = "#090909";
            border = "#090909";
            childBorder = "#FFFFFF";
            indicator = "#090909";
            text = "#090909"; };
          focusedInactive = {
            background = "#212121";
            border = "#212121";
            childBorder = "#FFFFFF";
            indicator = "#212121";
            text = "#212121"; };
          unfocused = {
            background = "#333333";
            border = "#222222";
            childBorder = "#888888";
            indicator = "#292D2E";
            text = "#222222"; };
          urgent = {
            background = "#2F343A";
            border = "#900000";
            childBorder = "#FFFFFF";
            indicator = "#900000";
            text = "#900000"; };
          placeholder = {
            background = "#000000";
            border = "#0C0C0C";
            childBorder = "#FFFFFF";
            indicator = "#000000";
            text = "#0C0C0C"; };
        };

        # Status bar
        bars = [
        {
          position = "bottom";
          statusCommand = "while date +'%Y-%m-%d %I:%M:%S %p'; do sleep 1; done";
          colors = {
            statusline          = "#FFFFFF";
            background          = "#000000";
            separator           = "#666666";
            focusedWorkspace   = {
              background = "#090909";
              border = "#090909";
              text = "#FFFFFF";
            };
            activeWorkspace    = {
              background = "#131313";
              border = "#333333";
              text = "#FFFFFF";
            };
            inactiveWorkspace  = {
              background = "#4B4B4B";
              border = "#393939";
              text = "#939393";
            };
            urgentWorkspace    = {
              background = "#2F343A";
              border = "#900000";
              text = "#FFFFFF";
            };
            bindingMode        = {
              background = "#2F343A";
              border = "#900000";
              text = "#FFFFFF";
            };
          };
        }
      ];
    };
  };
}
