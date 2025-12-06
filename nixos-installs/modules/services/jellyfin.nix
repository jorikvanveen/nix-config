{ pkgs, ... }: {  # Enable vaapi on OS-level
  services.jellyfin = {
    enable = true;
    user = "main";
    logDir = "/home/main/Jellyfin/logs";
    cacheDir = "/home/main/Jellyfin/cache";
    dataDir = "/home/main/Jellyfin/data";
    configDir = "/home/main/Jellyfin/config";
  };

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
  systemd.services.jellyfin = {
    environment.LIBVA_DRIVER_NAME = "iHD";
    serviceConfig = {
      SupplementaryGroups = [ "users" "video" ];
    };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = [
      pkgs.intel-media-driver
      #pkgs.intel-media-sdk
      pkgs.libva-vdpau-driver
      pkgs.intel-compute-runtime-legacy1
      pkgs.intel-ocl
    ];
  };
}
