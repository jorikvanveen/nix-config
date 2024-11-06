{ pkgs-stable, ... }: {
  programs.rust-motd = {
    enable = true;
    package = pkgs-stable.rust-motd;
    order = [ "banner" "filesystems" "docker" "service_status" "uptime" ];
    settings = {
      banner = {
        color = "white";
        command = ''${pkgs-stable.fastfetch.outPath}/bin/fastfetch'';
      };
      filesystems = {
        root = "/";
      };
      docker = {
        "/nextcloud" = "Nextcloud";
      };
      service_status = {
        Caddy = "caddy";
        Jellyfin = "jellyfin";
        Sonarr = "sonarr";
        Radarr = "radarr";
        Prowlarr = "prowlarr";
        Sabnzbd = "sabnzbd";
      };
      uptime = {
        prefix = "Up";
      };

    };
  };
}
