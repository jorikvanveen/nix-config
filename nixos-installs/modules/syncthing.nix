{ syncdir, homedir, ... }: let
in {
  services.syncthing = {
    enable = true;
    user = "main";
    dataDir = syncdir;
    configDir = homedir + "/.config/syncthing";
    openDefaultPorts = true;

    settings.folders.personal = {
      path = syncdir + "/personal";
      id = "personal";
      label = "personal";
      enable = true;
    };

    settings.options.relaysEnabled = true;
  };
}
