{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./alacritty.nix
    ./waybar.nix
    ./hyprland.nix
    ./sway.nix
  ];

  home.enableNixpkgsReleaseCheck = false;

  home.packages = [
    pkgs.vesktop
    pkgs.vlc
    pkgs.jellyfin-ffmpeg
    pkgs.uv
    pkgs.tmate
    pkgs.obsidian

    pkgs.papers # PDF
    pkgs.eog # IMAGES
    pkgs.xfce.thunar # FILES

    pkgs.kdePackages.kdenlive
    pkgs.gimp
    pkgs.parsec-bin
    pkgs.rofi-wayland

    pkgs.google-chrome
  ];

  programs.bottom = {
    enable = true;
  };

  services.mako = with config.colorScheme.palette; {
    enable = true;
    backgroundColor = "#000000";
    borderColor = "#595959";
    borderRadius = 5;
    borderSize = 2;
    textColor = "#${base04}";
    layer = "overlay";
  };

  programs.ranger.enable = true;
  xdg.configFile."ranger/rifle.conf".source = ./rifle.conf;
  xdg.configFile."mimeapps.list".source = ./mimeapps.list; # Default apps

}
