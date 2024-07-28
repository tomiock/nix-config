{ inputs, outputs, lib, config, ... }:
{
  # enable in NixOS config also (programs.hyprland.enable = true)
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = ["--all"];

    settings = {
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad.natural_scroll = "no";
      };

      general = {
        sensitivity = 1.0;
        gaps_in = 5;
        gaps_out = 5;
        border_size = 3;
        "col.active_border" = "rgba(d469ffee) rgba(970fffee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        drop_shadow = true;
        shadow_range = 100;
        shadow_render_power = 5;
        "col.shadow" = "0x33000000";
        "col.shadow_inactive" = "0x22000000";
        rounding = 1;
      };

      animations = {
        enabled = "yes";

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
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

      monitor = ",preferred,auto,auto";

      bind = [
        "SUPER,RETURN,exec,alacritty"
        ",Print,exec,~/.config/hypr/scripts/screenshot"
        "SUPER SHIFT,Q,killactive,"
        "SUPER SHIFT,E,exit,"
        "SUPER,S,togglefloating,"
        "SUPER,D,exec,rofi -show drun -show-icons"
        "SUPER SHIFT,D,exec,rofi -show run"
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
      ];
    };
  };
}
