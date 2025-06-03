{ syncdir, homedir, ... }: let
in {
  services.syncthing = {
    enable = true;
    user = "main";
    dataDir = syncdir;
    configDir = homedir + "/.config/syncthing";

    settings.folders.personal = {
      path = syncdir + "/personal";
      id = "personal";
      label = "personal";
      enable = true;
    };
  };
}
