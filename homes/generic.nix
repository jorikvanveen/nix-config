{ pkgs, homedir, ... }: {
  imports = [
    ./modules/git.nix
    ./modules/carapace.nix
    ./modules/starship.nix
    ./modules/nushell.nix
    ./modules/direnv.nix
    ./modules/custom_lsd.nix
    ./modules/alacritty.nix
    ./modules/neovim.nix
    ./modules/syncthing-ignore.nix
    ./modules/zoxide.nix
    ./modules/tmux.nix
    ./modules/bash.nix
    ./modules/home-manager.nix
    ./modules/atuin.nix

    ../packages/home_pkgs.nix
  ];
}
