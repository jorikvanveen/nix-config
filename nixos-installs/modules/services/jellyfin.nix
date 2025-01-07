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
    package = (pkgs.jellyfin.override {
      jellyfin-web = (pkgs.jellyfin-web.overrideAttrs (oldAttrs: {
        fixupPhase = ''
          ${oldAttrs.fixupPhase or ""}
          
          echo "Patching config.json"
          patch -p1 ${./jellyfin-rq-link.patch}
        '';

      }));
    });
  };

  systemd.services.jellyfin = {
    serviceConfig = {
      SupplementaryGroups = [ "users" "video" ];
    };
  };

  hardware.opengl = {
    enable = true;
    extraPackages = [
      pkgs.intel-media-driver
      pkgs.intel-media-sdk
      pkgs.intel-vaapi-driver
      pkgs.vaapiVdpau
      pkgs-stable.intel-compute-runtime
    ];
  };
}
