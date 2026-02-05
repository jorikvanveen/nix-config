{ config, lib, ... }: {
  specialisation = {
    niri-nvidia.configuration = {

      # Make gaming configuration an entry in the boot menu
      system.nixos.tags = [ "niri-nvidia" ];

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

        #prime = {
        #  nvidiaBusId = "PCI:1:0:0";
        #  intelBusId = "PCI:0:2:0";
        #  reverseSync.enable = true;
        #  allowExternalGpu = false;
        #};
      };
    };
  };
}
