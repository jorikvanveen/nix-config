{ pkgs, homedir, ... }: {
  home.file.zed = {
    enable = true;
    source = ../program-config/zed;
    target = homedir + "/.config/zed";
    recursive = true;
  };
  home.packages = import ../packages/home_pkgs.nix { inherit pkgs; };
}
