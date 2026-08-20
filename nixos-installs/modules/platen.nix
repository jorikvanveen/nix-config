{ pkgs, inputs, ... }: let 
  platen-backend = inputs.platen.packages.x86_64-linux.platen-backend;
  platen-frontend = inputs.platen.packages.x86_64-linux.platen-frontend;
in {
  systemd.services.platen-backend = {
    enable = true;
    description = "Platen Backend";
    after = [ "network.target" ];
    wants = [ "network-online.target" ];

    path = [ pkgs.unzip ];

    serviceConfig = {
      Type = "simple";
      User = "main";
      Group = "users";
      WorkingDirectory = "/var/lib/platen-backend";
      StateDirectory = "platen-backend";
      ExecStart = "${platen-backend}/bin/platen-backend";
      Restart = "on-failure";
      RestartSec = "5s";

      # Hardening
      # NoNewPrivileges = true;
      # PrivateTmp = true;
      # PrivateDevices = true;
      # ProtectSystem = "strict";
      # ProtectHome = true;
      # ProtectKernelTunables = true;
      # ProtectKernelModules = true;
      # ProtectControlGroups = true;
      # ReadWritePaths = [ "/var/lib/webserver" ];
      # RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
      # LockPersonality = true;
      # RestrictRealtime = true;
      # RestrictSUIDSGID = true;
      # RemoveIPC = true;
      # CapabilityBoundingSet = [ "" ];
      # AmbientCapabilities = [ "" ];

      # Resource limits
      LimitNOFILE = 65536;
      EnvironmentFile = "/run/secrets/platen-backend-env";
    };

    environment = rec {
      RUST_LOG = "info";
      PLATEN_BIND_ADDRESS = "0.0.0.0:43330";
      PLATEN_MUSIC_DIR = "/mnt/media/music";
      PLATEN_DATABASE_URL = "sqlite://${PLATEN_MUSIC_DIR}/platen-backend.sqlite?mode=rwc";
    };

    wantedBy = [ "multi-user.target" ];
  }; 

  systemd.services.platen-frontend = {
    enable = true;
    description = "Platen Frontend";
    after = [ "network.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "simple";
      User = "main";
      Group = "users";
      WorkingDirectory = "/var/lib/platen-frontend";
      StateDirectory = "platen-frontend";
      ExecStart = "${pkgs.nodejs}/bin/node ${platen-frontend}/index.js";
      Restart = "on-failure";
      RestartSec = "5s";

      # Hardening
      # NoNewPrivileges = true;
      # PrivateTmp = true;
      # PrivateDevices = true;
      # ProtectSystem = "strict";
      # ProtectHome = true;
      # ProtectKernelTunables = true;
      # ProtectKernelModules = true;
      # ProtectControlGroups = true;
      # ReadWritePaths = [ "/var/lib/webserver" ];
      # RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
      # LockPersonality = true;
      # RestrictRealtime = true;
      # RestrictSUIDSGID = true;
      # RemoveIPC = true;
      # CapabilityBoundingSet = [ "" ];
      # AmbientCapabilities = [ "" ];

      # Resource limits
      LimitNOFILE = 65536;
    };

    environment = {
      PUBLIC_PLATEN_BACKEND_URL = "/api";
      PORT = "43331";
    };

    wantedBy = [ "multi-user.target" ];
  }; 

  services.caddy.virtualHosts."platen.jorik-dev.com".extraConfig = ''
    basic_auth {
      platen $2y$05$gpFloq5HzrH75yLFQEwZu.LXLTJMuDoXUP7SpPTYlCy05JH8bQv72
    }
    handle_path /api/* {
      reverse_proxy http://localhost:43330
    }
    reverse_proxy http://localhost:43331
  '';
}
