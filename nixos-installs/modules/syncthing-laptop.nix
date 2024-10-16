{ homedir, ... }: {
  imports = [
    ./syncthing.nix
    ./sync-devices/pc.nix
  ];


}
