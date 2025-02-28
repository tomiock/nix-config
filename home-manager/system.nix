{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./uni.nix
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
    pkgs.zip
    pkgs.tmate
    pkgs.obsidian
    pkgs.obs-studio
    pkgs.pandoc

    pkgs.papers # PDF
    pkgs.eog # IMAGES
    pkgs.xfce.thunar # FILES

    pkgs.kdePackages.kdenlive
    pkgs.gimp
    pkgs.parsec-bin
    pkgs.qpdfview

    pkgs.google-chrome

    # TODO: try to find headless version
    pkgs.libreoffice

    pkgs.quickemu
    pkgs.minizinc
    pkgs.minizincide

    pkgs.mpage
    pkgs.imagemagick

    pkgs.jetbrains.pycharm-professional

    pkgs.texstudio
    pkgs.texliveTeTeX
    pkgs.gephi
  ];

  programs.bottom = {
    enable = true;
  };

  #services.printing.enable = true;

  services.mako = with config.colorScheme.palette; {
    enable = true;
    backgroundColor = "#${base01}";
    borderColor = "#${turquois}";
    borderRadius = 5;
    borderSize = 2;
    textColor = "#${base04}";
    layer = "overlay";

    defaultTimeout = 2000;
  };

  programs.tofi = {
    enable = true;
    settings = with config.colorScheme.palette; {
      background-color = "#000A";
      border-width = 0;
      outline-width = 0;
      text-color = "#${purple}";
      selection-color = "#${turquois}";
      font = "Hack Nerd Font";
      height = "100%";
      width = "100%";
      num-results = 5;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;
    };
  };

  programs.ranger.enable = true;
  xdg.configFile."ranger/rifle.conf".source = ./extra-files/rifle.conf;
  xdg.configFile."mimeapps.list".source = ./extra-files/mimeapps.list; # Default apps

  xdg.desktopEntries = {
    pika-backup = {
      name = "Pika Backup";
      exec = "pika-backup %U";
      terminal = false;
      categories = [ "Application" "Utility" ];
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      allow_remote_control = true;
      enable_audio_bell = false;
    };
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [

      viktorqvarfordt.vscode-pitch-black-theme

      ms-toolsai.jupyter
      ms-toolsai.vscode-jupyter-slideshow
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.jupyter-renderers
      ms-toolsai.jupyter-keymap

      ms-vscode.cpptools-extension-pack
      ms-python.python
      bbenoist.nix
      arrterian.nix-env-selector

      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
  };

}
