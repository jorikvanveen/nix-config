{ pkgs, ... }: { home.packages = [
  pkgs.ripgrep
  pkgs.jq
  pkgs.file
  pkgs.git
  pkgs.magic-wormhole
  pkgs.nixfmt
];}
