{ homedir, ... }: {
  imports = [
    ./syncthing.nix
    ./sync-devices/laptop.nix
    ./sync-devices/homelab.nix
    ./sync-devices/phone.nix
  ];

}
