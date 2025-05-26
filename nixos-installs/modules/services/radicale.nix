{
  services.radicale = {
    enable = true;
    settings = {
      server = {
        hosts = [ "0.0.0.0:5232" "[::]:5232" ];
      };
      auth = {
        type = "htpasswd";
        htpasswd_filename = "/run/secrets/radicale-htpasswd";
        htpasswd_encryption = "autodetect";
      };
      storage = {
        filesystem_folder = "/var/lib/radicale/collections";
      };
    };
  };
}
