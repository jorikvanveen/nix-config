{ pkgs, ... }: {
  systemd.timers."upload-backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      Unit = "upload-backup.service";
    };
  };

  systemd.services."upload-backup" = {
    path = [ pkgs.bash pkgs.rclone ];
    script = ''
      rclone --config /home/main/.config/rclone/rclone.conf sync /var/backup/ b2-encrypted:jorik-homelab-backups
    '';
    serviceConfig = {
      Type = "oneshot";
    };
  };
}
