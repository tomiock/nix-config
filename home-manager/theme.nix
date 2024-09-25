{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {

  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

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
      orange = "#A92258"; ## orange -- (burdeous)
      yellow = "#f3ff85"; ## yellow
      green = "#00ffa9"; ## poison green
      turquois = "#61ffca"; ## turquois
      aqua = "#0fd3ff"; ## aqua
      purple = "#970fff"; ## purple
      pink = "#953B9D"; ## pink -- (violet)
      red = "#ff6767"; ## light red
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
