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
    pkgs.tmate
    pkgs.obsidian

    pkgs.papers # PDF
    pkgs.eog # IMAGES
    pkgs.xfce.thunar # FILES

    pkgs.kdePackages.kdenlive
    pkgs.gimp
    pkgs.parsec-bin

    #pkgs.sublime4-dev

    pkgs.google-chrome

    # TODO: try to find headless version
    pkgs.libreoffice
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

  programs.tofi = {
    enable = true;
    settings = {
      background-color = "#000A";
      border-width = 0;
      outline-width = 0;
      text-color = "#970fff";
      selection-color = "#61ffca";
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

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      viktorqvarfordt.vscode-pitch-black-theme

      ms-vscode.cpptools-extension-pack
      ms-python.python
      bbenoist.nix

      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
  };

}
