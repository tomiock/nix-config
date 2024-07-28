{ config, pkgs, inputs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.tomi = {
      isDefault = true;
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        darkreader
        vimium
        ublock-origin
      ];
    };
  };
}
