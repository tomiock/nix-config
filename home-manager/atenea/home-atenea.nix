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
        "eDP-1,~/Pictures/wallpaper.jpg"
        "DP-1,~/Pictures/wallpaper.jpg"
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

