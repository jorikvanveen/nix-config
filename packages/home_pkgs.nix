{ pkgs, ... }: { home.packages = [
  pkgs.zed-editor

  pkgs.ripgrep
  pkgs.jq
  pkgs.file
  #pkgs.neovim
  pkgs.git
  pkgs.qbittorrent
  pkgs.magic-wormhole
];}
