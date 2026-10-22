{
  imports = [ ./torrent-network.nix ];

  virtualisation.oci-containers.containers.qbittorrent = {
    image = "lscr.io/linuxserver/qbittorrent:latest";
    networks = [ "torrenting" ];
    
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
      "54345:54345"
      "54345:54345/udp"
    ];
  };

  systemd.services.docker-qbittorrent = {
    requires = [ "docker-network-torrenting.service" ];
    after = [ "docker-network-torrenting.service" ];
  };

  networking.firewall.allowedTCPPorts = [ 54345 ];
  networking.firewall.allowedUDPPorts = [ 54345 ];
}
