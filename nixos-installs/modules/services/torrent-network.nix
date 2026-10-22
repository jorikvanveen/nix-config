{ config, ... }:
{
  systemd.services.docker-network-torrenting = {
    description = "Create the shared torrenting Docker network";
    requires = [ "docker.service" ];
    after = [ "docker.service" ];
    path = [ config.virtualisation.docker.package ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      if ! docker network inspect torrenting >/dev/null 2>&1; then
        docker network create --driver bridge torrenting
      fi
    '';
  };
}
