{ pkgs, inputs, ... }:

{
  imports = [
    inputs.xremap-flake.nixosModules.default
  ];

  programs.hyprland.xwayland.enable = true;

  xdg.mime.defaultApplications = {
    "image/jpg" = [ "eog.desktop" ];
    "image/png" = [ "eog.desktop" ];
    "application/pdf" = [ "papers.desktop" ];
  };

  services.xremap = {
    userName = "tomiock";
    withWlroots = true;

    config = {
      keymap = [
      /*
        {
          name = "arrow-key";
          remap = {
            alt-j = "down";
          };
        }
      */
        /*
        {
          name = "apps";
          remap.alt-f.lauch = [ "pavucontrol" ];
        }
        */
      ];
    };
  };
}
