{ pkgs, system, inputs, ... }:
{
  imports = [
    ./modules/lix.nix
    ./modules/locale.nix
    ./modules/x11-keymap.nix
    ./modules/cups.nix
    ./modules/env_vars.nix
    ./modules/distrobox.nix
    ./modules/syncthing.nix
    ./modules/stylix.nix
    ./modules/nix-ld.nix
    ./modules/unfree-allow.nix
    ./modules/dev-man-pages.nix
    ./modules/auto-gc.nix
    ./modules/flake-support.nix
    ./modules/flatpak.nix
    ./modules/ntfs-support.nix
  ];
}

