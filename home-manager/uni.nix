{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  home.packages = [
    pkgs.protege
  ];

}
