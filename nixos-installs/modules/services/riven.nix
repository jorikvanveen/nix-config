{ pkgs, ... }: {
  virtualisation.oci-containers.containers = {
    riven-frontend = {
      image = "spoked/riven-frontend:latest";
      ports = [
        "127.0.0.1:3033:3000"
      ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        ORIGIN = "https://riven.jorik-dev.com";
        BACKEND_URL = "http://riven:8080";
        DATABASE_URL = "postgres://postgres:postgres@riven-postgres:5432/riven";
        DIALECT = "postgres";
      };

      dependsOn = [ "riven" ];
    };

    riven = {
      hostname = "riven";
      image = "spoked/riven:v0.20.1";
      #image = "jorikvanveen/riven-torbox:v0.20.1";
      ports = [
        "127.0.0.1:8088:8080"
      ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        RIVEN_FORCE_ENV = "true";
        RIVEN_DATABASE_HOST = "postgresql+psycopg2://postgres:postgres@riven-postgres:5432/riven";
      };
      volumes = [
        "/home/main/data/riven:/riven/data"
        "/mnt/torbox-library:/mnt/torbox-library:ro"
        "/mnt/riven-library:/mnt/riven-library"
      ];
      dependsOn = [ "riven-postgres" ];
      #extraOptions = [
      #  "--health-cmd=\"curl -s http://localhost:8080 >/dev/null || exit 1\""
      #  "--health-interval=30s"
      #  "--health-timeout=10s"
      #  "--health-retries=10"
      #];
    };

    riven-postgres = {
      hostname = "riven-postgres";
      image = "postgres:17.0-alpine3.20";
      volumes = [ "/home/main/data/riven-pg:/var/lib/postgresql/data/pgdata" ];
      ports = [
        "127.0.0.1:5255:5432"
      ];
      environment = {
        PGDATA = "/var/lib/postgresql/data/pgdata";
        POSTGRES_USER = "postgres";
        POSTGRES_PASSWORD = "postgres";
        POSTGRES_DB = "riven";
      };
      #extraOptions = [
      #  "--health-cmd=pg_isready"
      #  "--health-interval=10s"
      #  "--health-timeout=5s"
      #  "--health-retries=5"
      #];
    };
  };
}
