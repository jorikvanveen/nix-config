{ pkgs, ... }: {
  #virtualisation.oci-containers.containers.hermes = {
  #  image = "nousresearch/hermes-agent:latest";
  #  autoStart = true;
  #  cmd = [ "gateway" "run" ];
  #  environmentFiles = [
  #    /run/secrets/hermes-env
  #  ];
  #  environment = {
  #    HERMES_UID = "1000";
  #    HERMES_GID = "1000";
  #    HERMES_DASHBOARD = "1";
  #    HERMES_DASHBOARD_HOST = "0.0.0.0";
  #    HERMES_DASHBOARD_PORT = "9119";
  #    API_SERVER_ENABLED = "true";
  #    API_SERVER_HOST = "0.0.0.0";
  #  };
  #  volumes = [
  #    "/home/main/data/hermes:/opt/data"
  #  ];
  #  ports = [
  #    "127.0.0.1:8642:8642"
  #    "127.0.0.1:9119:9119"
  #  ];
  #  dependsOn = [ "signal-rest-api" ];
  #};
  
  services.caddy.virtualHosts."hermes.jorik-dev.com".extraConfig = ''
    reverse_proxy http://localhost:9119
  '';
  
  virtualisation.incus.enable = true;
  networking.nftables.enable = true;
  networking.firewall.trustedInterfaces = [ "incusbr0" ];
}
