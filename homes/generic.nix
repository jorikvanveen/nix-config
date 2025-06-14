{ pkgs, inputs, system, ... }:
let pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${system};
in {
  imports = [
    ./modules/git.nix
    ./modules/carapace.nix
    ./modules/starship.nix
    ./modules/nushell.nix
    ./modules/direnv.nix
    ./modules/custom_lsd.nix
    ./modules/neovim.nix
    ./modules/syncthing-ignore.nix
    ./modules/zoxide.nix
    ./modules/tmux.nix
    ./modules/bash.nix
    ./modules/home-manager.nix
    ./modules/atuin.nix
    ./modules/archive-tools.nix

  ];

  home.packages = [
    pkgs.ripgrep
    pkgs.jq
    pkgs.file
    pkgs.git
    pkgs-stable.magic-wormhole # Broken on unstable (29 dec 2024)
    pkgs.nixfmt
    pkgs.uv
    pkgs.ffmpeg
    pkgs.nixd
    pkgs.posting
    pkgs.htop
    pkgs.wget
    pkgs.man-pages-posix
    pkgs.man-pages
    pkgs.tree
  ];
}
