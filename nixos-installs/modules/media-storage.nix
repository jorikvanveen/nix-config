{ pkgs, ... }:

{
  system.fsPackages = [ pkgs.mergerfs ];

  fileSystems."/mnt/disks/media-0" = {
    device = "/dev/disk/by-uuid/0a3ee84d-b6b2-4aa0-9a6c-5dd64d49b2e1";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  fileSystems."/mnt/disks/media-1" = {
    device = "/dev/disk/by-uuid/45ffd81b-6cdc-4a67-a3b9-ff12480ca36e";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  fileSystems."/mnt/media" = {
    device = "/mnt/disks/media-0:/mnt/disks/media-1";
    fsType = "mergerfs";
    noCheck = true; # fsck runs on the ext4 branches, not the virtual pool.
    depends = [ "/mnt/disks/media-0" "/mnt/disks/media-1" ];
    options = [
      "nofail"
      "allow_other"
      # New files go to the disk with the most available space.
      "category.create=mfs"
      "minfreespace=50G"
      # Support mmap users, including the SQLite database used by Platen.
      "cache.files=auto-full"
      "dropcacheonclose=true"
      "func.getattr=newest"
      "x-systemd.requires=media-storage-permissions.service"
    ];
  };

  # Set only the new filesystem's root permissions, after it is mounted.
  # Existing files and permissions on the original disk are preserved.
  systemd.services.media-storage-permissions = {
    description = "Prepare the new media disk for writes";
    unitConfig.RequiresMountsFor = [ "/mnt/disks/media-1" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.coreutils}/bin/install -d -o main -g users -m 0755 /mnt/disks/media-1";
    };
  };
}
