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
      ExecStop = "/biun/fusermount -u /mnt/torbox-webdav";
    };
    #serviceConfig.SupplementaryGroups = [ "fuse" ];
    script = "${pkgs.rclone}/bin/rclone mount Torbox: /mnt/torbox-webdav --allow-other --vfs-cache-mode full";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
  };
}
