{ homedir, ... }: {
  imports = [
    ./syncthing.nix
  ];

  services.syncthing = {
    settings.devices.pc = {
      id = "TXMWH2O-4PTEIVD-3XS7IBS-UXJT7BE-GTKEMU5-RY7WORS-S24S4ET-BNDMXQB";
      name = "pc";
    };

    settings.folders.personal.devices = [ "pc" ];
  };
}
