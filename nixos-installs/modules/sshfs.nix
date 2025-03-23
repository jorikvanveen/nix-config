{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.rclone ];

  environment.etc."sshfs-qbd.conf".text = ''
    [jorik-dev]
    type = sftp
    host = j.jorik-dev.com
    user = main
    key_file = /home/main/.ssh/id_ed25519
  '';

  fileSystems."/mnt/qb" = {
    device = "jorik-dev:/mnt/media/data/qbittorrent/downloads";
    fsType = "rclone";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      "args2env"
      "dir-cache-time=10s"
      "config=/etc/sshfs-qbd.conf"
    ];
  };
}
