{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.rclone ];
  systemd.services.torbox-rclone = {
    serviceConfig.User = "main";
    script = "rclone mount Torbox: /mnt/torbox-library/ --vfs-cache-mode full";
  };
}
