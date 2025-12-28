#{
#  virtualisation.oci-containers.containers.qbittorrent = {
#    image = "lscr.io/linuxserver/qbittorrent:latest";
#    
#    environment = {
#      DOCKER_MODS = "ghcr.io/vuetorrent/vuetorrent-lsio-mod:latest";
#      PUID = "1000";
#      PGID = "1000";
#      WEBUI_PORT = "8080";
#      TORRENTING_PORT = "54345";
#    };
#
#    volumes = [
#      "/mnt/media/data/qbittorrent/appdata:/config"
#      "/mnt/media/data/qbittorrent/downloads:/downloads"
#    ];
#
#    ports = [
#      "127.0.0.1:8081:8080"
#      "54345:54345"
#      "54345:54345/udp"
#    ];
#  };
#
#  networking.firewall.allowedTCPPorts = [ 54345 ];
#  networking.firewall.allowedUDPPorts = [ 54345 ];
#}
{
  virtualisation.oci-containers.containers.cross-seed = {
    image = "ghcr.io/cross-seed/cross-seed:latest";
    environment = {
      PUID = "1000";
      PGID = "1000";
    };
    ports = [ "127.0.0.1:2468:2468" ];
    volumes = [
      "/home/main/.config/cross-seed/:/config"
      "/mnt/media/data/qbittorrent/downloads:/downloads"
    ];
    cmd = [ "daemon" ];
  };
    #services.cross-seed = {
    #  # "/mnt/media/data/qbittorrent/downloads:/downloads"

    #  enable = true;
    #  user = "main";
    #  group = "users";
    #  configDir = "/home/main/.config/cross-seed";
    #  settingsFile = "/home/main/.config/cross-seed-settings.json";
    #  settings.port = 2468;
    #  settings.dataDirs = [
    #    "/mnt/media/data/qbittorrent/downloads"
    #  ];

    #  settings.torrentDir = "/mnt/media/data/qbittorrent/appdata/qBittorrent/BT_backup";
    #};
}
#version: "2.1"
#services:
#  cross-seed:
#    image: ghcr.io/cross-seed/cross-seed:6
#    container_name: cross-seed
#    user: 1000:1000 # this must match your torrent client (cross-seed does not support using PGID and PUID)
#    ports:
#      - "2468:2468"
#    volumes:
#      - /path/to/config/folder:/config
#      - # You will need at least one extra volume for your media drive if using https://www.cross-seed.org/docs/tutorials/linking
#    command: daemon
#    restart: unless-stopped

