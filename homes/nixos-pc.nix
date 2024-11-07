{ lib, homedir, pkgs, ... }:
{
  imports = [
    ./generic.nix
    ./generic-desktop.nix
    ./modules/zed-node-fix.nix
    ./modules/close-with-x.nix
    ./modules/main-user.nix
  ];
}
