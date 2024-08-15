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
    pkgs.kdePackages.kdenlive
    pkgs.gimp
    pkgs.parsec-bin
    # pkgs.obsidian-export
  ];

  programs.bottom = {
    enable = true;
  };

  services.mako = with config.colorScheme.palette; {
    enable = true;
    backgroundColor = "#000000";
    borderColor = "#0c0c0c";
    borderRadius = 5;
    borderSize = 2;
    textColor = "#${base04}";
    layer = "overlay";
  };
}