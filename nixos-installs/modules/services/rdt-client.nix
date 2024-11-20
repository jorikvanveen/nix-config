{
  virtualisation.oci-containers.containers.rdt-client = {
    image = "rogerfar/rdt-client:latest";
    environment = {
      PUID = "1000";
      PGID = "1000";
      TZ = "Europe/Amsterdam";
    };

    volumes = [
      "/home/main/data/rdt-client:/data"
    ];

    ports = [
      "6500:6500"
    ];
  };
}
