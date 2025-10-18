{ pkgs, ... }:
{
  services.actual = {
    enable = true;
    settings.port = 30313;
    settings.hostname = "0.0.0.0";
  };

  systemd.timers."actual-flow-import" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      Unit = "actual-flow-import.service";
    };
  };

  systemd.services."actual-flow-import" = {
    path = [ pkgs.bash pkgs.nodejs ];
    script = ''
      set -eu
      cd /home/main/data/actual-flow
      ${pkgs.nodejs}/bin/npx --yes @lunchflow/actual-flow import
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "main";
    };
  };
}
