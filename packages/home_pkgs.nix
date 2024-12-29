{ pkgs, pkgs-stable, ... }: { home.packages = [
  pkgs.ripgrep
  pkgs.jq
  pkgs.file
  pkgs.git
  pkgs-stable.magic-wormhole # Broken on unstable (29 dec 2024)
  pkgs.nixfmt
];}
