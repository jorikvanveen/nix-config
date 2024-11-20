{
  virtualisation.oci-containers.containers.rdtclient = {
    image = "packetshepard/rdt-client";
    environment = {
      PUID = "1000";
      PGID = "1000";
      TZ = "Europe/Amsterdam";
      FILE__PASSWORD = "/run/secrets/rdt-client-pw";
    };

    volumes = [
      "/home/main/data/rdt-client:/data"
    ];

    ports = [
      "127.0.0.1:6500:6500"
    ];
  };
}
