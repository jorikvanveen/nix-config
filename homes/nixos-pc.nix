{ lib, homedir, pkgs, ... }:
{
  imports = [
    ./generic.nix
    ./generic-desktop.nix
    ./modules/zed-node-fix.nix
    ./modules/main-user.nix
    ./modules/reaper-extensions.nix
  ];
}
