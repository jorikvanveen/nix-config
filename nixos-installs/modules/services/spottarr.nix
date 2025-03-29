{
  virtualisation.oci-containers.containers.spottarr = {
    image = "ghcr.io/spottarr/spottarr:latest";
    environmentFiles = [
      "/run/secrets/spottarr-usenet-pw"
      "/run/secrets/spottarr-usenet-name"
    ];
    environment = {
      "USENET__HOSTNAME" = "news.eweka.nl";
      #"USENET__USERNAME=username"
      #"USENET__PASSWORD=somep@ssw0rd"
      "USENET__PORT" = "563";
      "USENET__USETLS" = "true";
      "USENET__MAXCONNECTIONS" = "10";
      "SPOTNET__RETRIEVEAFTER" = "2010-01-01T00:00:00Z";
      "SPOTNET__IMPORTBATCHSIZE" = "10000";
      "SPOTNET__IMPORTADULTCONTENT" = "false";
    };
    volumes = [
      "/mnt/media/data/spotarr:/data"
    ];
    ports = [
      "127.0.0.1:8383:8383"
    ];
  };
}
