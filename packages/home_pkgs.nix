{ pkgs, ... }: { home.packages = [
  pkgs.zed-editor
  pkgs.brave

  pkgs.ripgrep
  pkgs.jq
  pkgs.tmux
  pkgs.file
  pkgs.neovim
  pkgs.git
  pkgs.obsidian
  pkgs.vesktop
];}
