{
  services.syncthing = {
    imports = [
      ./syncthing.nix
      ./sync-devices/laptop.nix
      ./sync-devices/pc.nix
    ];

    guiAddress = "0.0.0.0:8384";
  };
}
