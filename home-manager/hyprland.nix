{ inputs, outputs, lib, config, ... }:
{
# enable in NixOS config also (programs.hyprland.enable = true)
  wayland.windowManager.hyprland = {
    enable = true;
    settigs = {
      input = {
        kb_layout = us;
        follow_mouse = 1;
        touchpad.natural_scroll = no;
      };
      general = {
        sensitivity = 1.0;
        gaps_in = 5;
        gaps_out = 5;
        border_size = 3;
        "col.active_border" = "rgba (d469ffee) rgba (970 fffee) 45 deg";
        "col.inactive_border" = "rgba (595959aa)";
        layout = dwindle;
        allow_tearing = false;
      };
    };
  };
}
