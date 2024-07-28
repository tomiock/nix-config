# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./firefox.nix
    ./alacritty.nix
    ./waybar.nix
  ];

  nixpkgs = {
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "tominix";
    homeDirectory = "/home/tominix";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
  };

  programs.eza.enable = true;
  programs.zoxide.enable = true;

  colorScheme = {
    slug = "tomiock";
    name = "tomiock";
    author = "tomiock";
    palette = {
      base00 = "#000000"; ## ---- dark
      base01 = "#100323"; ## ---
      base02 = "#3E2D5C"; ## --
      base03 = "#edecee"; ## -
      base04 = "#edecee"; ## +
      base05 = "#DEDCDF"; ## ++
      base06 = "#edecee"; ## +++
      base07 = "#edecee"; ## ++++ light
      orange = "#A92258"; ## orange
      yellow = "#f3ff85"; ## yellow
       green = "#61ff7b"; ## poison green
    turquois = "#61ffca"; ## turquois
        aqua = "#0fd3ff"; ## aqua
      purple = "#970fff"; ## purple
        pink = "#953B9D"; ## pink
         red = "#ff6767"; ## light red
    };
  };

  programs.zsh = {
    enable = true;
    autocd = true;

    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "exa";
      sl = "exa";
      l = "exa -l";
      la = "exa -la";
      ip = "ip --color=auto";
      c = "clear";
    };

    oh-my-zsh = {
      enable = true;
      theme = "kolo";
      plugins = [
        "git"
        "thefuck"
      ];
    };

  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "tomiock";
    userEmail = "ockier1@gmail.com";
    aliases = {
      pu = "push";
      cm = "commit";
    };
  };

  gtk = {
    enable = true;
    theme.name = "adw-gtk3";
    cursorTheme.name = "Bibata-Modern-Ice";
    iconTheme.name = "GruvboxPlus";
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

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
