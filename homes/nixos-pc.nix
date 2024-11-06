{ lib, homedir, pkgs, ... }:
{
  imports = [
    ./generic.nix
    ./modules/stylix.nix
    ./modules/zed-node-fix.nix
    ./modules/mime-associations.nix
    ./modules/close-with-x.nix
    ./modules/main-user.nix
    ./modules/zed.nix
  ];
}
