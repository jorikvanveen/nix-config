let
   environmentFiles = [
     /run/secrets/hoarder-meili-master
     /run/secrets/hoarder-nextauth-secret
     /run/secrets/hoarder-openai-key
   ];
in {
  virtualisation.oci-containers.containers = {
    hoarder-web = {
      inherit environmentFiles;
      image = "ghcr.io/hoarder-app/hoarder:release";
      volumes = [
        "/mnt/media/data/hoarder-web:/data"
      ];
      ports = [
        "3131:3000"
      ];
      environment = {
        HOARDER_VERSION = "release";
        NEXTAUTH_URL = "https://hoarder.jorik-dev.com";
        DATA_DIR = "/data";
        MEILI_ADDR = "http://hoarder-meili:7700";
        BROWSER_WEB_URL = "https://hoarder.jorik-dev.com";
      };
    };

    hoarder-meili = {
      inherit environmentFiles;
      image = "getmeili/meilisearch:v1.11.1";
      environment = {
        MEILI_NO_ANALYTICS = "true";
      };
      volumes = [
        "/mnt/media/data/hoarder-meili:/meili_data"
      ];
    };
  };
}

