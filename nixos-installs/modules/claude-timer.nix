{ pkgs, ... }: {
  systemd.user.services.claude-refresh = {
    script = ''
      set -eu
      ${pkgs.claude-code}/bin/claude "hi"
    '';
    serviceConfig = {
      Type = "oneshot";
      RuntimeMaxSec = "5";
      TimeoutStopSec = "2";
      KillMode = "mixed";
    }; 
  };
  systemd.user.timers.claude-refresh-timer = {
    timerConfig = {
      Unit = "claude-refresh.service";
      OnCalendar = [
        "06:00:00 Europe/Amsterdam"
        "11:01:00 Europe/Amsterdam"
        "16:02:00 Europe/Amsterdam"
      ];
      Persistent = true;
      RemainAfterElapse = false;
    };
    wantedBy = [ "timers.target" ];
  };
}
