{ homedir, ... }: {
  imports = [
    ./syncthing.nix
  ];

  services.syncthing = {
    settings.devices.laptop = {
      id = "CRVGMNS-2EOYL2F-WDTAGUX-4TFNI62-OFPL4JR-QYNTB3B-4ON4XXJ-SVZVEQZ";
      name = "laptop";
    };

    settings.folders.personal.devices = [ "laptop" ];
  };
}
