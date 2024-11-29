{
  virtualisation.oci-containers.containers.zurg = {
    image = "ghcr.io/debridmediamanager/zurg-testing:latest";
    ports = [
      "9999:9999"
    ];

    environment = {
      PUID = "1000";
      PGID = "1000";
    };

    volumes = [
      "/home/main/data/zurg:/app/data"
      "/home/main/.config/zurg/config.yml:/app/config.yml"
    ];
  };
}
