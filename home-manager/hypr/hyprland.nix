{ pkgs, inputs, outputs, lib, config, ... }:
let rootPath = ../.;
in
{

  home.packages = [
    pkgs.swaybg
  ];

  home.file = {
    start = {
      enable = true;
      target = "\"$HOME\"/.config/hypr/";
      source = rootPath + /hypr/start.sh;
    };
  };

  # enable in NixOS config also (programs.hyprland.enable = true)
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [ "--all" ];

    /*
      plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      ];
    */

    settings = {


      monitor =
        [
          ",preferred,auto,auto"
          "desc:Chimei Innolux Corporation 0x1552,preferred,auto-down,1"
        ];

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

      exec-once = [
        "bash $HOME/nixconfig/home-manager/hypr/start.sh"
      ];
    };
  };
}

#  monitor=,preferred,auto,auto
#  
#  input {
#      kb_layout= us
#      kb_variant=
#      kb_model=
#      kb_options=
#      kb_rules=
#  
#      follow_mouse=1
#  
#      touchpad {
#          natural_scroll=no
#      }
#  }
#  
#  misc{
#      
#  }
#  
#  general {
#      sensitivity=1.0 # for mouse cursor    
#      gaps_in=5
#      gaps_out=5
#      border_size=3
#      col.active_border = rgba(d469ffee) rgba(970fffee) 45deg
#      col.inactive_border = rgba(595959aa)
#  
#      layout = dwindle
#  
#      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
#      allow_tearing = false
#  }
#  
#  decoration {
#      drop_shadow = true
#      shadow_range=100
#      shadow_render_power=5
#      col.shadow= 0x33000000
#      col.shadow_inactive=0x22000000
#      rounding=1
#  }
#  
#  
#  
#  animations {
#      enabled = yes
#  
#      bezier = myBezier, 0.05, 0.9, 0.1, 1.05
#      animation = windows, 1, 7, myBezier
#  }
#  
#  dwindle {
#      pseudotile=1 # enable pseudotiling on dwindle
#      force_split=0
#  }
#  
#  master{
#      
#  }
#  
#  gestures {
#      workspace_swipe=yes
#      workspace_swipe_fingers=4
#  }
#  
#  # example window rules
#  # for windows named/classed as abc and xyz
#  #windowrule=move 69 420,abc
#  windowrule=move center,title:^(fly_is_kitty)$
#  windowrule=size 800 500,title:^(fly_is_kitty)$
#  windowrule=animation slide,title:^(all_is_kitty)$
#  windowrule=float,title:^(all_is_kitty)$
#  #windowrule=tile,xy
#  windowrule=tile,title:^(kitty)$
#  windowrule=float,title:^(fly_is_kitty)$
#  windowrule=float,title:^(clock_is_kitty)$
#  windowrule=size 418 234,title:^(clock_is_kitty)$
#  #windowrule=pseudo,abc
#  #windowrule=monitor 0,xyz
#  
#  # example binds
#  bindm=SUPER,mouse:272,movewindow
#  bindm=SUPER,mouse:273,resizewindow
#  
#  bind=SUPER,RETURN,exec,alacritty
#  bind=,Print,exec,~/.config/hypr/scripts/screenshot
#  bind=SUPER SHIFT,Q,killactive,
#  bind=SUPER SHIFT,E,exit,
#  bind=SUPER,S,togglefloating,
#  bind=SUPER,D,exec,rofi -show drun -show-icons
#  bind=SUPER SHIFT,D,exec,rofi -show run
#  bind=SUPER,P,pseudo,
#  bind=SUPER,F,fullscreen
#  
#  #bind=SUPER SHIFT,L,exec,~/.config/hypr/scripts/lock
#  
#  bind=SUPER,H,movefocus,l
#  bind=SUPER,L,movefocus,r
#  bind=SUPER,K,movefocus,u
#  bind=SUPER,J,movefocus,d
#  
#  # bind=CTRL,1,workspace,1
#  # bind=CTRL,2,workspace,2
#  # bind=CTRL,3,workspace,3
#  # bind=CTRL,4,workspace,4
#  # bind=CTRL,5,workspace,5
#  # bind=CTRL,6,workspace,6
#  bind=SUPER,1,workspace,1
#  bind=SUPER,2,workspace,2
#  bind=SUPER,3,workspace,3
#  bind=SUPER,4,workspace,4
#  bind=SUPER,5,workspace,5
#  bind=SUPER,6,workspace,6
#  bind=SUPER,7,workspace,7
#  bind=SUPER,8,workspace,8
#  bind=SUPER,9,workspace,9
#  bind=SUPER,0,workspace,10
#  
#  bind=SUPER SHIFT,1,movetoworkspace,1
#  bind=SUPER SHIFT,2,movetoworkspace,2
#  bind=SUPER SHIFT,3,movetoworkspace,3
#  bind=SUPER SHIFT,4,movetoworkspace,4
#  bind=SUPER SHIFT,5,movetoworkspace,5
#  bind=SUPER SHIFT,6,movetoworkspace,6
#  bind=SUPER SHIFT,7,movetoworkspace,7
#  bind=SUPER SHIFT,8,movetoworkspace,8
#  bind=SUPER SHIFT,9,movetoworkspace,9
#  bind=SUPER SHIFT,0,movetoworkspace,10
#  
#  bind=SUPER,mouse_down,workspace,e+1
#  bind=SUPER,mouse_up,workspace,e-1
#  
#  bind=SUPER,g,togglegroup
#  bind=SUPER,tab,changegroupactive
#  
#  #######
#  exec-once=bash ~/.config/hypr/start.sh
#  
