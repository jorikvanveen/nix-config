{ homedir, ... }: {
  home.file.zed = {
    enable = true;
    source = ../../program-config/zed;
    target = homedir + "/.config/zed";
    recursive = true;
  };
}

