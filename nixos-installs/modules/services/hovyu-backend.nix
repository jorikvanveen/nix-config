{
  virtualisation.oci-containers.containers.hovyu-backend = {
    image = "localhost/hovyu-backend:latest";
    #environmentFiles = [
    #  "/run/secrets/spottarr-usenet-pw"
    #  "/run/secrets/spottarr-usenet-name"
    #];
    #environment = {
    #  "USENET__HOSTNAME" = "news.eweka.nl";
    #  #"USENET__USERNAME=username"
    #  #"USENET__PASSWORD=somep@ssw0rd"
    #  "USENET__PORT" = "563";
    #  "USENET__USETLS" = "true";
    #  "USENET__MAXCONNECTIONS" = "50";
    #  "SPOTNET__RETRIEVEAFTER" = "2024-01-01T00:00:00Z";
    #  "SPOTNET__IMPORTBATCHSIZE" = "10000";
    #  "SPOTNET__IMPORTADULTCONTENT" = "false";
    #};
    #volumes = [
    #  "/mnt/media/data/spottarr:/data"
    #];
    ports = [
      "127.0.0.1:8000:8000"
    ];
  };
}
