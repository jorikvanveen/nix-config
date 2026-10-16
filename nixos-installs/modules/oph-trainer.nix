{ pkgs, inputs, ... }:
let
  oph-trainer = inputs.oph-trainer.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  sops.secrets.oph-trainer-env.restartUnits = [ "oph-trainer.service" ];

  systemd.services.oph-trainer = {
    description = "Orpheus Interview Trainer";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    environment = {
      RUST_LOG = "info";
      OPH_BIND_ADDRESS = "127.0.0.1:43332";
      OPH_DATABASE_URL = "sqlite:///var/lib/oph-trainer/oph-trainer.db?mode=rwc";
      OPH_USE_X_FORWARDED_FOR = "true";
    };

    serviceConfig = {
      ExecStart = "${oph-trainer}/bin/oph-trainer-backend";
      DynamicUser = true;
      StateDirectory = "oph-trainer";
      WorkingDirectory = "/var/lib/oph-trainer";
      # Optional OPH_OPENROUTER_API_KEY; without it, explanations use self-assessment.
      EnvironmentFile = "-/run/secrets/oph-trainer-env";
      Restart = "on-failure";
      RestartSec = "5s";
      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = true;
    };
  };

  services.caddy.virtualHosts."oph-trainer.jorik-dev.com".extraConfig = ''
    reverse_proxy http://127.0.0.1:43332 {
      header_up X-Forwarded-For {remote_host}
    }
  '';
}
