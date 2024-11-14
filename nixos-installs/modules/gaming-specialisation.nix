{ config, ... }: {
  specialisation = {
    gaming.configuration = {
      # Disable gnome
      services.xserver.displayManager.gdm.enable = false;
      services.xserver.desktopManager.gnome.enable = false;

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
        package = config.boot.kernelPackages.nvidiaPackages.beta;

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
