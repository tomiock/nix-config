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

    ./firefox.nix
    ./alacritty.nix
    ./waybar.nix
    ./hyprland.nix
    ./neovim.nix
  ];

  nixpkgs = {
    config = {
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
    GDK_BACKEND = "wayland";
    GTK_USE_PORTAL = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.packages = [
    pkgs.vesktop
    pkgs.vlc
    pkgs.uv
    pkgs.tmate
    # pkgs.kdePackages.kdenlive
    # pkgs.obsidian-export
  ];

  programs.eza.enable = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.bat.enable = true;

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

  programs.ripgrep.enable = true;

  programs.zsh = {
    enable = true;
    autocd = true;

    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "exa";
      sl = "exa";
      l = "exa -la";
      la = "exa --all --oneline";
      ip = "ip --color=auto";
      c = "clear";
      grep = "rg";
      cat = "bat --style plain";
      cd = "z";
      pip = "uv";
    };

    oh-my-zsh = {
      enable = true;
      theme = "kolo";
      plugins = [
        "git"
      ];
    };
  };
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    shortcut = "a";
    sensibleOnTop = true;

    extraConfig = ''

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

    '';
  };

  programs.thefuck = {
    enable = true;
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
      s = "status";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
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

  programs.bottom = {
    enable = true;
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
