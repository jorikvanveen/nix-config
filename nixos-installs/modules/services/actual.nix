{ pkgs, ... }: {
  services.actual = {
    enable = true;
    settings.port = 30313;
    settings.hostname = "0.0.0.0";
  };

  systemd.user.services."actual-flow-import" = {
    Unit = {
      Description = "Actual Flow Import";
    };
    Service = {
      Type = "oneshot";
      WorkingDirectory = "/home/main/data/actual-flow";
      ExecStart = "${pkgs.nodejs}/bin/npx --yes @lunchflow/actual-flow import";
    };
  };

  systemd.user.timers."actual-flow-import" = {
    Unit = {
      Description = "Run Actual Flow Import daily";
    };
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
