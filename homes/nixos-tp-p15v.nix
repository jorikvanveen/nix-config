{ lib, homedir, ... }:
{
  imports = [
    ./generic.nix
    ./modules/zed-node-fix.nix
    ./modules/mime-associations.nix
    ./modules/main-user.nix
  ];
}
