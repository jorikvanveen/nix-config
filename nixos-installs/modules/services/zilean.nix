{
  virtualisation.oci-containers.containers = {
    zilean = {
      image = "ipromknight/zilean:v3.3.1";
      ports = [
        "127.0.0.1:8181:8181"
      ];
      volumes = [
        "/home/main/data/zilean-data:/app/data"
        "/home/main/data/zilean-tmp:/tmp"
      ];
      dependsOn = [ "zilean-pg" ];
    };

    zilean-pg = {
      image = "postgres:17.1";
      environment = {
        PGDATA = "/var/lib/postgresql/data/pgdata";
        POSTGRES_USER = "postgres";
        POSTGRES_PASSWORD = "postgres";
        POSTGRES_DB = "zilean";
      };

      volumes = [
        "/home/main/data/zilean-pg:/var/lib/postgresql/data/pgdata"
      ];
    };
  };
}
