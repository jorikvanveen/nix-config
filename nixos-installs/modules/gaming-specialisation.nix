{ config, lib, ... }: {
  specialisation = {
    gaming.configuration = {
      # Disable gnome
      services.xserver.displayManager.gdm.enable = false;
      services.xserver.desktopManager.gnome.enable = false;

      # Disable niri, ags bar, dunst
      programs.niri.enable = lib.mkForce false;
      services.gnome.evolution-data-server.enable = lib.mkForce true;
      services.gnome.gnome-online-accounts.enable = lib.mkForce true;
      services.gnome.gnome-keyring.enable = lib.mkForce true;
      systemd.user.services.ags-bar = lib.mkForce {};
      systemd.user.services.swaybg = lib.mkForce {};

      # Enable KDE plasma 6
      services.displayManager.sddm.enable = true;
      services.displayManager.sddm.wayland.enable = true;
      services.desktopManager.plasma6.enable = true;

      # Make gaming configuration an entry in the boot menu
      system.nixos.tags = [ "gaming" ];

      # Enable proprietary nvidia drivers
      services.xserver.videoDrivers = [ "nvidia" ];

      # https://wiki.nixos.org/wiki/Nvidia
      hardware.nvidia = {
        # Required
        modesetting.enable = true;

        # Fixes issues with sleep/suspend.
        powerManagement.enable = false;

        # Turns off the gpu when not in use.
        # powerManagement.finegrained = true;

        # Uses the open kernel modules
        open = true;

        # Enable nvidia-settings GUI
        nvidiaSettings = true;

        # .production is nvidia-550 at the time of writing
        package = config.boot.kernelPackages.nvidiaPackages.production;

        prime = {
          nvidiaBusId = "PCI:1:0:0";
          intelBusId = "PCI:0:2:0";
          reverseSync.enable = true;
          allowExternalGpu = false;
        };
      };
    };
  };
}
