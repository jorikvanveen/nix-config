{
  virtualisation.oci-containers.containers.qbittorrent = {
    image = "lscr.io/linuxserver/qbittorrent:latest";
    
    environment = {
      DOCKER_MODS = "ghcr.io/vuetorrent/vuetorrent-lsio-mod:latest";
      PUID = "1000";
      PGID = "1000";
      WEBUI_PORT = "8080";
      TORRENTING_PORT = "54345";
    };

    volumes = [
      "/mnt/media/data/qbittorrent/appdata:/config"
      "/mnt/media/data/qbittorrent/downloads:/downloads"
    ];

    ports = [
      "127.0.0.1:8081:8080"
      "127.0.0.1:54345:54345"
      "127.0.0.1:54345:54345/udp"
    ];
  };

  networking.firewall.allowedTCPPorts = [ 54345 ];
  networking.firewall.allowedUDPPorts = [ 54345 ];
}
