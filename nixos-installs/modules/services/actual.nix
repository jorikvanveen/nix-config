{ pkgs, ... }:
{
  services.actual = {
    enable = true;
    settings.port = 30313;
    settings.hostname = "0.0.0.0";
  };

  systemd.user.timers."actual-flow-import" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      Unit = "actual-flow-import.service";
    };
  };

  systemd.user.services."actual-flow-import" = {
    script = ''
      set -eu
      ${pkgs.nodejs}/bin/npx --yes @lunchflow/actual-flow import
    '';
    serviceConfig = {
      Type = "oneshot";
      DynamicUser = true;
      WorkingDirectory = "/home/main/data/actual-flow/"; 
    };
  };
}
