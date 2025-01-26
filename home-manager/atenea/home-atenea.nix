# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
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
        [
          "~/Pictures/jinx.webp"
          "~/Pictures/jinx_vertical.webp"
        ];

      wallpaper = [
        "eDP-1,~/Pictures/jinx.webp"
        "DP-1,~/Pictures/jinx.webp"
        "DP-2,~/Pictures/jinx.webp"
        "DP-3,~/Pictures/jinx.webp"
        "DP-4,~/Pictures/jinx.webp"
        "DP-5,~/Pictures/jinx.webp"
        "DP-6,~/Pictures/jinx_vertical.webp"
        "DP-7,~/Pictures/jinx_vertical.webp"
        "HDMI-A-1,~/Pictures/jinx.webp"
      ];
    };
  };

  programs.zsh.shellAliases = {
    bbg = "swaybg --color \"#000000\"";
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}

