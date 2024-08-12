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
    # pkgs.obsidian-export
  ];

  programs.bottom = {
    enable = true;
  };

  services.mako = with config.colorScheme.palette; {
    enable = true;
    backgroundColor = "#${base01}";
    borderColor = "#${purple}";
    borderRadius = 5;
    borderSize = 2;
    textColor = "#${base04}";
    layer = "overlay";
  };
}
