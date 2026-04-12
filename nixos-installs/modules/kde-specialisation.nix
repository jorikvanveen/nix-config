{ config, lib, ... }: {
  specialisation = {
    kde.configuration = {

      # Make gaming configuration an entry in the boot menu
      system.nixos.tags = [ "kde" ];

      imports = [
        ./kde.nix
      ];
      
      programs.niri.enable = lib.mkForce false;
      services.xserver.desktopManager.gnome.enable = lib.mkForce false;
      services.xserver.displayManager.gdm.enable = lib.mkForce false;
      services.gnome.evolution-data-server.enable = lib.mkForce false;
      services.gnome.gnome-online-accounts.enable = lib.mkForce false;
      services.gnome.gnome-keyring.enable = lib.mkForce false;
      systemd.user.services.ags-bar = lib.mkForce {};
      services.gvfs.enable = lib.mkForce false;

      services.displayManager.sddm.enable = lib.mkForce true;
      services.displayManager.sddm.wayland.enable = lib.mkForce true;

      hardware.graphics.enable = true;
    };
  };
}
