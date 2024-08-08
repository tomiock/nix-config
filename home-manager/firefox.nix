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

      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };

        "Home Manager Options" = {
          urls = [{
            template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=release-24.05";
          }];

          definedAliases = [ "@mo" ];
        };
      };
    };
  };
}
