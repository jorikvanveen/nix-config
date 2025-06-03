{ pkgs, system, inputs, ... }: let pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${system}; in { home.packages = [
  pkgs.ripgrep
  pkgs.jq
  pkgs.file
  pkgs.git
  pkgs-stable.magic-wormhole # Broken on unstable (29 dec 2024)
  pkgs.nixfmt
];}
