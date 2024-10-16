{ homedir, ... }:
let
  shareddir = homedir + "/shared";
in {
  services.syncthing = {
    enable = true;
    user = "main";
    dataDir = shareddir;
    configDir = "/home/main/.config/syncthing";

    settings.folders.personal = {
      path = shareddir + "/personal";
      id = "personal";
      label = "personal";
      enable = true;
    };
  };
}
