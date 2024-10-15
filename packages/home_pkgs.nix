{ pkgs, ... }: { home.packages = [
  pkgs.zed-editor

  pkgs.ripgrep
  pkgs.jq
  pkgs.tmux
  pkgs.file
  pkgs.neovim
  pkgs.git
  pkgs.qbittorrent
];}
