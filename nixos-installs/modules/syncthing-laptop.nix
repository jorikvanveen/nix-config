{ homedir, ... }: {
  imports = [
    ./syncthing.nix
    ./sync-devices/pc.nix
    ./sync-devices/homelab.nix
  ];
}
