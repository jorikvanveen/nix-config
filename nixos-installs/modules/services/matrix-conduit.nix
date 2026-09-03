{
  services.matrix-conduit = {
    enable = true;
    secretFile = "/run/secrets/matrix-conduit";
    settings.global = {
      server_name = "matrix.jorik-dev.com";
      allow_registration = false;
      port = 6167;
    };
  };
  
  services.caddy.virtualHosts."matrix.jorik-dev.com".extraConfig = ''
    reverse_proxy http://localhost:6167
  '';
}
