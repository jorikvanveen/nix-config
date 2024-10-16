{ homedir, ... }: {
  imports = [
    ./syncthing.nix
    ./sync-devices/laptop.nix
  ];

}
