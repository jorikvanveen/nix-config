{ homedir, config, dotfiledir, ... }: {
  home.file.niri-config = {
    target = homedir + "/.config/niri/config.kdl";
    source = config.lib.file.mkOutOfStoreSymlink dotfiledir + "/niri/config.kdl";
  };
  services.dunst.enable = true;
}
