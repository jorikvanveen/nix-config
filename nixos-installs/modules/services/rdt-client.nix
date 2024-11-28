{
  virtualisation.oci-containers.containers.rdtclient = {
    image = "rogerfar/rdtclient:2.0.89";

    environment = {
      PUID = "1000";
      PGID = "1000";
      TZ = "Europe/Amsterdam";
      FILE__PASSWORD = "/run/secrets/rdt-client-pw";
    };

    volumes = [
      "/home/main/data/rdt-client/db:/data/db"
      "/home/main/data/rdt-client/downloads:/data/downloads"
    ];

    ports = [
      "127.0.0.1:6500:6500"
    ];
  };
}
