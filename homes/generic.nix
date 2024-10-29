{ pkgs, homedir, ... }: {
  imports = [
    ./modules/git.nix
    ./modules/carapace.nix
    ./modules/starship.nix
    ./modules/nushell.nix
    ./modules/direnv.nix
    ./modules/custom_lsd.nix
    ./modules/alacritty.nix
    ./modules/stylix.nix
    ./modules/neovim.nix
    ./modules/syncthing-ignore.nix
    ./modules/zoxide.nix
    ./modules/tmux.nix
    ./modules/zed.nix
    ./modules/bash.nix
    ./modules/home-manager.nix
    ./modules/atuin.nix

    ./modules/dconf/enable-nightlight.nix
    ./modules/dconf/extensions.nix
    ./modules/dconf/font-rendering.nix
    ./modules/dconf/fractional-scaling.nix
    ./modules/dconf/keybinds.nix
    ./modules/dconf/keyboard-layout.nix
    ./modules/dconf/no-middle-click-paste.nix
    ./modules/dconf/window-prefs.nix

    ../packages/home_pkgs.nix
  ];
}
