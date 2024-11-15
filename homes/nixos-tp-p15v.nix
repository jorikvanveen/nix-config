{ lib, homedir, ... }:
{
  imports = [
    ./generic.nix
    ./generic-desktop.nix
    ./modules/zed-node-fix.nix
    ./modules/main-user.nix
  ];

}
