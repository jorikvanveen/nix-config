{ pkgs, homedir, dotfiledir, config, ... }: {
  home.file.zed-keymap = {
    target = homedir + "/.config/zed/keymap.json";
    source = config.lib.file.mkOutOfStoreSymlink dotfiledir + "/zed/keymap.json";
  };
  home.file.zed-settings = {
    target = homedir + "/.config/zed/settings.json";
    source = config.lib.file.mkOutOfStoreSymlink dotfiledir + "/zed/settings.json";
  };
  
  home.packages = [ pkgs.zed-editor ];
}
