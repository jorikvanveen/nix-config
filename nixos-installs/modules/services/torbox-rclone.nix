{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.rclone ];
  programs.fuse.userAllowOther = true;
  systemd.services.torbox-rclone = {
    serviceConfig = {
      User = "main";
      Group = "users";
      PermissionsStartOnly = true;
      PrivateMounts = "no";
      ProtectSystem = "no";
      DeviceAllow = "/dev/fuse";
      CapabilityBoundingSet = "CAP_SYS_ADMIN";
      AmbientCapabilities = "CAP_SYS_ADMIN";
      ExecStop = "/bin/fusermount -u /mnt/torbox-webdav";
    };
    #serviceConfig.SupplementaryGroups = [ "fuse" ];
    #script = "${pkgs.rclone}/bin/rclone mount Torbox: /mnt/torbox-webdav --allow-other --poll-interval 0 --dir-cache-time 10s --vfs-cache-mode full";
    script = "${pkgs.rclone}/bin/rclone mount Torbox: /mnt/torbox-webdav --allow-other --dir-cache-time 10s --vfs-cache-mode full";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
  };
}
