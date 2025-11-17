{
  virtualisation.oci-containers.containers.hovyu-backend = {
    image = "hovyu-backend:latest";
    environment = {
      "DJANGO_BASEDIR" = "/data";
    };
    volumes = [
      "/home/main/data/hovyu-backend:/data"
    ];
    ports = [
      "127.0.0.1:8000:8000"
    ];
  };
}
