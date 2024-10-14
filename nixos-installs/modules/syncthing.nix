{
  services.syncthing = {
    enable = true;
    user = "main";
    # TODO: This is bad
    dataDir = "/home/main/Documents";
    configDir = "/home/main/.config/syncthing";
  };
}
