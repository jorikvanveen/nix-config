{ config, lib, ... }: {
  specialisation = {
    kde-nvidia.configuration = {

      # Make gaming configuration an entry in the boot menu
      system.nixos.tags = [ "kde-nvidia" ];

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
