{
  imports = [
    ./syncthing.nix
    ./sync-devices/laptop.nix
    ./sync-devices/pc.nix
    ./sync-devices/phone.nix
  ];

  services.syncthing.guiAddress = "0.0.0.0:8384";
}
