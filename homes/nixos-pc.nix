{ lib, homedir, ... }:
{
  imports = [
    ./generic.nix
    ./modules/zed-node-fix.nix
    ./modules/mime-associations.nix
    ./modules/close-with-x.nix
    ./modules/main-user.nix
  ];

  dconf.settings = import ../dconf.nix { inherit lib; };
}
