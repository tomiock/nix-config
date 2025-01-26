{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ../system.nix
    ../zsh.nix
    ../theme.nix

    ../firefox.nix
    ../neovim.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "tomiock";
    homeDirectory = "/home/tomiock";
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = true;
      #splash_offset = 2.0;

      preload =
        ["~/Pictures/wallpaper.jpg"];

      wallpaper = [
        "DP-1,~/Pictures/wallpaper.jpg"
        "DP-2,~/Pictures/wallpaper.jpg"
        "DP-3,~/Pictures/wallpaper.jpg"
        "DP-4,~/Pictures/wallpaper.jpg"
        "DP-5,~/Pictures/wallpaper.jpg"
        "DP-6,~/Pictures/wallpaper.jpg"
        "DP-7,~/Pictures/wallpaper.jpg"
        "DP-8,~/Pictures/wallpaper.jpg"
        "HDMI-A-1,~/Pictures/wallpaper.jpg"
      ];
    };
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}

