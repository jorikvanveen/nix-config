{
  #services.plausible = {
  #  enable = true;
  #  package = pkgs-stable.plausible;
  #  server.port = 8087;
  #  server.listenAddress = "127.0.0.1";
  #  server.baseUrl = "/";
  #  server.secretKeybaseFile = "/run/secrets/plausible-phx-secret";

  #  adminUser.name = "jorik";
  #  adminUser.email = "none@none.com";
  #  adminUser.passwordFile = "/run/secrets/plausible-password";
  #};

  # virtualisation.oci-containers.containers = {
  #   plausible = {
  #     image = "plausible/analytics";
  #     ports = [ "127.0.0.1:8087:8000" ];
  #     environment = {
  #       OVERWRITEPROTOCOL = "https";
  #     };
  #   };

  #   plausible-db = {
  #     image = "postgres:16-alpine"; 
  #     restart = "always";
  #     volumes = [ "/home/main/data/plausible-pg:/var/lib/postgresql/data" ];
  #   };
  # };

}
