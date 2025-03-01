{ pkgs, inputs, outputs, lib, config, ... }:
let rootPath = ../.;
in
  {

  home.packages = [
    pkgs.networkmanagerapplet
    pkgs.brightnessctl
    pkgs.hyprshot
    pkgs.hyprpicker

    (pkgs.writeShellScriptBin "start_hyprland"
      ''
      #!/usr/bin/env bash

      nm-applet --indicator &

      mako &
      '')

    (pkgs.writeShellScriptBin "video_record"
      ''
      #!/usr/bin/env bash

      timestamp=$(date -u +"%Y_%m_%d__%H_%M_%S")

      output_file="video_''${timestamp}"

      wf-recorder -g "$(slurp -d)" --file="$HOME/Videos/''${output_file}.mkv"

      ffmpeg -i "$HOME/Videos/''${output_file}.mkv" -c:v libx264 -crf 20 -vf format=yuv420p "$HOME/Videos/''${output_file}.mp4"

      #rm "$HOME/Videos/''${output_file}.mkv"

      notify-send "video stored"
    ''
    )
  ];

  # enable in NixOS config also (programs.hyprland.enable = true)
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    systemd.variables = [ "--all" ];

    extraConfig = ''
      env = WLR_NO_HARDWARE_CURSORS,1
    '';

    settings = {

      monitor =
        [
          ",preferred,auto,auto"
          "desc:Chimei Innolux Corporation 0x1552,preferred,0x0,1"
          "desc:Dell Inc. DELL U2715H GH85D4B60FDL,preferred,0x-1440,1"
          "desc:Dell Inc. DELL U2414H 9TG464CD481L,preferred,2560x-2000,1,transform,3"
          "desc:Seiko Epson Corporation EPSON PJ 0x01010101,1920x1080,auto-right,1,mirror,ePD-1"
        ];

      input = {
        kb_layout = "us,es";
        kb_options = "grp:caps_toggle";
        follow_mouse = 1;
        touchpad.natural_scroll = "no";
      };

      general = {
        #sensitivity = 1.0;
        gaps_in = 5;
        gaps_out = 5;
        border_size = 3;
        "col.inactive_border" = "rgba(0f0f0f00)";
        "col.active_border" = " rgba(61ffca55) rgba(970fff55) rgba(970fff55) rgba(00ffa955) 45deg";
        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        #enabled = "yes";
        #drop_shadow = true;
        #shadow_range = 100;
        #shadow_render_power = 5;
        #"col.shadow" = "rgba*=(00000099";
        #"col.shadow_inactive" = "0x22000000";
        rounding = 10;
      };

      animations = {
        enabled = "yes";

        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
          "liner, 1, 1, 1, 1"
          "wind, 0.05, 0.9, 0.1, 1.05"
        ];

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 7, default"
          "workspaces, 1, 3, wind"
        ];
      };

      dwindle = {
        pseudotile = 1;
        force_split = 0;
      };

      gestures = {
        workspace_swipe = "yes";
        workspace_swipe_fingers = 4;
      };

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        "float, title:(Select one or more files to open)$"
        "size 25% 25%, title:(Select one or more files to open)$, floating:0"

        "float, title:(File Upload)$"
        "size 50% 50%, title:(File Upload)$, floating:1"

        "float, title:(Save As)$"
        "size 50% 50%, title:(Save As)$, floating:1"

        "float, title:(Pick Files)$"
        "size 50% 50%, title:(Pick Files)$, floating:1"

        "float, title:(Open Image)$"
        "size 50% 50%, title:(Open Image)$, floating:1"

        "float, title:(Alacritty)$"
        "size 50% 98%, class:(Alacritty)(.*)$, floating:0"
        #"move 500, 900, title:(Alacritty)"
        "tile, title:(Alacritty)$"
      ];

      bind = [
        "SUPER,RETURN,exec,alacritty"

        ",Print,exec,hyprshot -m region -z --clipboard-only" # simple screenshot
        "SHIFT,Print,exec,bash video_record" # start recording
        "SUPER SHIFT,Print,exec,pkill --signal 15 wf-recorder" # stop recording

        "SUPER SHIFT,Q,killactive,"
        ''SUPER SHIFT,E,exec,exec swaynag -t warning -m "You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session." -B "Yes, exit sway" "swaymsg exit"''

        "SUPER,S,togglefloating,"
        "SUPER,S,centerwindow,"

        "SUPER,D,exec, tofi-drun --drun-launch=true "
        "SUPER SHIFT,D,exec, tofi-run --drun-launch=true"
        "SUPER,P,pseudo,"
        "SUPER,F,fullscreen"

        "SUPER,H,movefocus,l"
        "SUPER,L,movefocus,r"
        "SUPER,K,movefocus,u"
        "SUPER,J,movefocus,d"

        "SUPER SHIFT,H,movewindow,l"
        "SUPER SHIFT,L,movewindow,r"
        "SUPER SHIFT,K,movewindow,u"
        "SUPER SHIFT,J,movewindow,d"

        "SUPER,1,workspace,1"
        "SUPER,2,workspace,2"
        "SUPER,3,workspace,3"
        "SUPER,4,workspace,4"
        "SUPER,5,workspace,5"
        "SUPER,6,workspace,6"
        "SUPER,7,workspace,7"
        "SUPER,8,workspace,8"
        "SUPER,9,workspace,9"
        "SUPER,0,workspace,10"

        "SUPER SHIFT,1,movetoworkspace,1"
        "SUPER SHIFT,2,movetoworkspace,2"
        "SUPER SHIFT,3,movetoworkspace,3"
        "SUPER SHIFT,4,movetoworkspace,4"
        "SUPER SHIFT,5,movetoworkspace,5"
        "SUPER SHIFT,6,movetoworkspace,6"
        "SUPER SHIFT,7,movetoworkspace,7"
        "SUPER SHIFT,8,movetoworkspace,8"
        "SUPER SHIFT,9,movetoworkspace,9"
        "SUPER SHIFT,0,movetoworkspace,10"

        "SUPER,mouse_down,workspace,e+1"
        "SUPER,mouse_up,workspace,e-1"

        "SUPER,g,togglegroup"
        "SUPER,tab,changegroupactive"

        ",XF86MonBrightnessDown,exec,brightnessctl set 10%-"
        ",XF86MonBrightnessUp,exec,brightnessctl set 10%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      exec-once = [
        "bash start_hyprland"
      ];
    };
  };
}
