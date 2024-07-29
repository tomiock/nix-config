{ outputs
, config
, lib
, pkgs
, inputs
, ...
}:

{
  # TODO: configure mpd with a local server

  home.packages = [
    pkgs.networkmanagerapplet
  ];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 30;
        modules-left = [ "hyprland/workspaces" "hyprland/mode" "wlr/taskbar"];
        modules-center = [ "custom/hello-from-waybar" ];
        modules-right = [ "tray" "temperature" ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        "custom/hello-from-waybar" = {
          format = "hello {}";
          max-length = 40;
          interval = "once";
          exec = pkgs.writeShellScript "hello-from-waybar" ''
            echo "from within waybar"
          '';
        };
      };
    };
  };
}
