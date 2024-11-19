{ pkgs, inputs, ... }:

{
  imports = [
    inputs.xremap-flake.nixosModules.default
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.xremap = {
    userName = "tomiock";
    withWlroots = true;

    config = {
      keymap = [
        /*
{
name = "arrow-key";
remap = {
alt-j = "down";
};
}
*/
        /*
{
name = "apps";
remap.alt-f.lauch = [ "pavucontrol" ];
}
*/
      ];
    };
  };
}
