{
  virtualisation.oci-containers = {
    containers = {
      nextcloud = {
        image = "nextcloud";
        ports = [ "127.0.0.1:8900:80" ];
        volumes = [
          "/home/main/data/next-data:/var/www/html"
        ];
        environment = {
          OVERWRITEPROTOCOL = "https";
        };
      };
    };
  };
}
