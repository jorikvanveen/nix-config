{
  virtualisation.oci-containers.containers.zurg = {
    image = "ghcr.io/debridmediamanager/zurg-testing:latest";
    hostname = "zurg";
    ports = [
      "127.0.0.1:9999:9999"
    ];

    environment = {
      PUID = "1000";
      PGID = "1000";
    };

    volumes = [
      "/home/main/data/zurg:/app/data"
      "/home/main/.config/zurg/config.yml:/app/config.yml"
    ];
  };

 virtualisation.oci-containers.containers.rclone = {
   image = "rclone/rclone:latest";
   environment = {
     PUID = "1000";
     PGID = "1000";
   };
   volumes = [
     "/mnt/torbox-library:/data:rshared"
     "/home/main/.config/zurg/rclone.conf:/config/rclone/rclone.conf"
     "/home/main/data/rclone-cache:/root/.cache/rclone"
   ];
   extraOptions = ["--privileged" "--cap-add" "SYS_ADMIN" ];

   cmd = [ "mount" "zurg:" "/data" "--allow-other" "--allow-non-empty" "--dir-cache-time" "10s" "--vfs-cache-mode" "full" ];
 };
}
