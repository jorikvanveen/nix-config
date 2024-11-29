{
  virtualisation.oci-containers.containers = {
    riven-frontend = {
      image = "spoked/riven-frontend:latest";
      ports = [
        "3033:3000"
      ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        ORIGIN = "https://riven.jorik-dev.com/";
        BACKEND_URL = "http://localhost:8088";
        DATABASE_URL = "postgres://postgres:postgres@localhost:5255/riven";
        DIALECT = "postgres";
      };

      dependsOn = [ "riven" ];
    };

    riven = {
      image = "spoked/riven:latest";
      ports = [
        "8088:8080"
      ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        RIVEN_FORCE_ENV = "true";
        RIVEN_DATABASE_HOST = "postgresql+psycopg2://postgres:postgres@localhost:5255/riven";
      };
      volumes = [
        "/home/main/data/riven:/riven/data"
        "/mnt:/mnt"
      ];
      dependsOn = [ "riven-postgres" ];
    };

    riven-postgres = {
      image = "postgres:17.0-apline3.20";
      volumes = [ "/home/main/data/riven-pg:/var/lib/postgresql/data/pgdata" ];
      environment = {
        PGDATA = "/var/lib/postgresql/data/pgdata";
        POSTGRES_USER = "postgres";
        POSTGRES_PASSWORD = "postgres";
        POSTGRES_DB = "riven";
      };
    };
  };
}
