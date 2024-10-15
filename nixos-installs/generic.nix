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
    ../packages/system_pkgs.nix
    spicetify-nix.nixosModules.default
  ];

  programs.spicetify.enable = true;

  networking.networkmanager.enable = true;
  services.xserver.enable = true;
  hardware.graphics.enable = true;
  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
}
