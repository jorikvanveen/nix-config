{ homedir, lib, ... }: {
  home = {
    username = "main";
    homeDirectory = lib.mkForce homedir;
    stateVersion = "24.05";
  };
}
