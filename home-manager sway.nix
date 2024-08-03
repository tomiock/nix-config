{ pkgs, inputs, outputs, lib, config, ... }:
let rootPath = ../.;
in
{

  home.packages = [
    pkgs.networkmanagerapplet
    pkgs.brightnessctl
    pkgs.swaybg
    (pkgs.writeShellScriptBin "start_hyprland"
    ''
      #!/usr/bin/env bash

        nm-applet --indicator &

        swaybg --image "/home/tominix/Pictures/Tokyo_Pink.png" --mode fill &

        mako &
    '')
  ];

  programs.sway = {
      enable = true;

      config = {
        # Set variables
        mod = "Mod4";
        term = "alacritty";
        menu = "dmenu_path | dmenu | xargs swaymsg exec --";

        # Input configuration
        input = {
          "1739:52781:SYNA2BA6:00_06CB:CE2D_Touchpad" = {
            dwt = true;
            tap = true;
            natural_scroll = true;
            middle_emulation = true;
          };
        };

        # Keybindings
        keybindings = [
          { modifiers = [ "Mod4" ]; key = "Return"; action = "exec $term"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "q"; action = "kill"; }
          { modifiers = [ "Mod4" ]; key = "d"; action = "exec $menu"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "r"; action = "reload"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "e"; action = ''exec swaynag -t warning -m "You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session." -B "Yes, exit sway" "swaymsg exit"''; }
          { modifiers = [ "Mod4" ]; key = "h"; action = "focus left"; }
          { modifiers = [ "Mod4" ]; key = "j"; action = "focus down"; }
          { modifiers = [ "Mod4" ]; key = "k"; action = "focus up"; }
          { modifiers = [ "Mod4" ]; key = "l"; action = "focus right"; }
          { modifiers = [ "Mod4" ]; key = "Left"; action = "focus left"; }
          { modifiers = [ "Mod4" ]; key = "Down"; action = "focus down"; }
          { modifiers = [ "Mod4" ]; key = "Up"; action = "focus up"; }
          { modifiers = [ "Mod4" ]; key = "Right"; action = "focus right"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "h"; action = "move left"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "j"; action = "move down"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "k"; action = "move up"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "l"; action = "move right"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "Left"; action = "move left"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "Down"; action = "move down"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "Up"; action = "move up"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "Right"; action = "move right"; }
          { modifiers = [ "Mod4" ]; key = "1"; action = "workspace number 1"; }
          { modifiers = [ "Mod4" ]; key = "2"; action = "workspace number 2"; }
          { modifiers = [ "Mod4" ]; key = "3"; action = "workspace number 3"; }
          { modifiers = [ "Mod4" ]; key = "4"; action = "workspace number 4"; }
          { modifiers = [ "Mod4" ]; key = "5"; action = "workspace number 5"; }
          { modifiers = [ "Mod4" ]; key = "6"; action = "workspace number 6"; }
          { modifiers = [ "Mod4" ]; key = "7"; action = "workspace number 7"; }
          { modifiers = [ "Mod4" ]; key = "8"; action = "workspace number 8"; }
          { modifiers = [ "Mod4" ]; key = "9"; action = "workspace number 9"; }
          { modifiers = [ "Mod4" ]; key = "0"; action = "workspace number 10"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "1"; action = "move container to workspace number 1"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "2"; action = "move container to workspace number 2"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "3"; action = "move container to workspace number 3"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "4"; action = "move container to workspace number 4"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "5"; action = "move container to workspace number 5"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "6"; action = "move container to workspace number 6"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "7"; action = "move container to workspace number 7"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "8"; action = "move container to workspace number 8"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "9"; action = "move container to workspace number 9"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "0"; action = "move container to workspace number 10"; }
          { modifiers = [ "Mod4" ]; key = "b"; action = "splith"; }
          { modifiers = [ "Mod4" ]; key = "v"; action = "splitv"; }
          { modifiers = [ "Mod4" ]; key = "s"; action = "layout stacking"; }
          { modifiers = [ "Mod4" ]; key = "w"; action = "layout tabbed"; }
          { modifiers = [ "Mod4" ]; key = "e"; action = "layout toggle split"; }
          { modifiers = [ "Mod4" ]; key = "f"; action = "fullscreen"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "space"; action = "floating toggle"; }
          { modifiers = [ "Mod4" ]; key = "space"; action = "focus mode_toggle"; }
          { modifiers = [ "Mod4" ]; key = "a"; action = "focus parent"; }
          { modifiers = [ "Mod4" "Shift" ]; key = "minus"; action = "move scratchpad"; }
          { modifiers = [ "Mod4" ]; key = "minus"; action = "scratchpad show"; }
          { modifiers = [ "Mod4" ]; key = "r"; action = "mode \"resize\""; }
        ];

        # Resize mode
        modes =  {
          "resize" = {
            keybindings = [
              { modifiers = [ ]; key = "h"; action = "resize shrink width 10px"; }
              { modifiers = [ ]; key = "j"; action = "resize grow height 10px"; }
              { modifiers = [ ]; key = "k"; action = "resize shrink height 10px"; }
              { modifiers = [ ]; key = "l"; action = "resize grow width 10px"; }
              { modifiers = [ ]; key = "Left"; action = "resize shrink width 10px"; }
              { modifiers = [ ]; key = "Down"; action = "resize grow height 10px"; }
              { modifiers = [ ]; key = "Up"; action = "resize shrink height 10px"; }
              { modifiers = [ ]; key = "Right"; action = "resize grow width 10px"; }
              { modifiers = [ ]; key = "Return"; action = "mode \"default\""; }
              { modifiers = [ ]; key = "Escape"; action = "mode \"default\""; }
            ];
          };
        };

        # Colors
        colors = {
          focused          = "#090909 #090909 #FFFFFF #090909   #090909";
          focusedInactive  = "#212121 #212121 #FFFFFF #212121   #212121";
          unfocused        = "#333333 #222222 #888888 #292D2E   #222222";
          urgent           = "#2F343A #900000 #FFFFFF #900000   #900000";
          placeholder      = "#000000 #0C0C0C #FFFFFF #000000   #0C0C0C";
        };

        # Status bar
        bar = {
          position = "bottom";
          status_command = "while date +'%Y-%m-%d %I:%M:%S %p'; do sleep 1; done";
          colors = {
            statusline          = "#FFFFFF";
            background          = "#000000";
            separator           = "#666666";
            focused_workspace   = "#090909 #090909 #FFFFFF";
            active_workspace    = "#131313 #333333 #FFFFFF";
            inactive_workspace  = "#4B4B4B #393939 #939393";
            urgent_workspace    = "#2F343A #900000 #FFFFFF";
            binding_mode        = "#2F343A #900000 #FFFFFF";
          };
        };
    };
  };
}
