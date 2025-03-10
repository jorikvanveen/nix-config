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
        BROWSER_WEB_URL = "http://hoarder-browser:9222";
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

    hoarder-browser = {
       image = "gcr.io/zenika-hub/alpine-chrome:123";
       #pull = "newer";
       cmd = [
          "--no-sandbox"
          "--disable-gpu"
          "--disable-dev-shm-usage"
          "--remote-debugging-address=0.0.0.0"
          "--remote-debugging-port=9222"
          "--hide-scrollbars"
       ];
    };
  };
}

