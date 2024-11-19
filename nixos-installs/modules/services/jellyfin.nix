{ pkgs, pkgs-stable, pinned-pkgs, ... }: {  # Enable vaapi on OS-level
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  services.jellyfin = {
    enable = true;
    user = "main";
    logDir = "/home/main/Jellyfin/logs";
    cacheDir = "/home/main/Jellyfin/cache";
    dataDir = "/home/main/Jellyfin/data";
    configDir = "/home/main/Jellyfin/config";
    package = pkgs-stable.jellyfin;
  };

  hardware.opengl = {
    enable = true;
    extraPackages = [
      pkgs.intel-media-driver
      pkgs.intel-media-sdk
      pkgs.intel-vaapi-driver
      pkgs.vaapiVdpau
      pkgs.intel-compute-runtime
    ];
  };
}
