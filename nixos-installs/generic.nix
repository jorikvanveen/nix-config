{ spicetify-nix, ... }: {
  imports = [
    ./modules/locale.nix
    ./modules/gnome.nix
    ./modules/x11-keymap.nix
    ./modules/cups.nix
    ./modules/pipewire.nix
    ./modules/steam.nix
    ./modules/gamemode.nix
    ./modules/env_vars.nix
    ./modules/fix-java-fonts.nix
    ./modules/distrobox.nix
    ./modules/syncthing.nix
    ./modules/mullvad.nix
    ./modules/stylix.nix
    ./modules/xanmod-kernel.nix
    ./modules/spicetify.nix
    ./modules/nix-ld.nix
    ./modules/systemd-boot.nix
    ./modules/bluetooth.nix
    ./modules/graphics.nix
    ./modules/network.nix
    ./modules/unfree-allow.nix
    ../packages/system_pkgs.nix
  ];

}
