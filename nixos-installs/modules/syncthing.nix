{ syncdir, ... }:
{
  services.syncthing = {
    enable = true;
    user = "main";
    dataDir = syncdir;
    configDir = "/home/main/.config/syncthing";

    settings.folders.personal = {
      path = syncdir + "/personal";
      id = "personal";
      label = "personal";
      enable = true;
    };
  };
}
