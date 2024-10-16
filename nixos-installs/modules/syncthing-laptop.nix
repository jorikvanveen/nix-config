{ homedir, ... }: {
  imports = [
    ./syncthing.nix
  ];

  services.syncthing = {
    settings.devices.pc = {
      id = "5E777XO-Y43G7RH-ILBGF6T-L7G4HUB-UTCQ4KC-BYOMVDA-NRIVROU-XWEVTQD";
      name = "pc";
    };

    settings.folders.personal.devices = [ "pc" ];
  };
}
