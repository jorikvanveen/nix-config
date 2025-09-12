{ pkgs, lib, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware/nixos-homelab-hardware.nix

    ./generic-cli.nix

    ./modules/main-user.nix
    ./modules/syncthing-homelab.nix
    ./modules/systemd-boot.nix
    ./modules/sops.nix
    ./modules/podman.nix
    ./modules/ignore-lid-switch.nix
    ./modules/nvidia.nix

    ./modules/services/atuin.nix
    ./modules/services/jellyfin.nix
    ./modules/services/radarr.nix
    ./modules/services/sonarr.nix
    ./modules/services/jackett.nix
    ./modules/services/prowlarr.nix
    ./modules/services/sabnzbd.nix
    ./modules/services/open-webui.nix
    ./modules/services/caddy.nix
    ./modules/services/nextcloud.nix
    ./modules/services/rust-motd.nix
    ./modules/services/ssh.nix
    ./modules/services/minecraft.nix
    ./modules/services/plausible.nix
    ./modules/services/rdt-client.nix
    ./modules/services/qbittorrent.nix
    ./modules/services/earlyoom.nix
    ./modules/services/zilean.nix
    ./modules/services/zurg.nix
    ./modules/services/navidrome.nix
    ./modules/services/gonic.nix
    ./modules/services/spottarr.nix
    ./modules/services/lidarr.nix
    ./modules/services/riven.nix
    ./modules/services/vaultwarden.nix
    ./modules/services/hoarder.nix
    ./modules/services/audiobookshelf.nix
    ./modules/services/radicale.nix
    ./modules/services/calibre-web.nix
    ./modules/services/ebookdl-web.nix
    ./modules/services/hovyu-backend.nix
  ];

  environment.systemPackages = [
    pkgs.neovim
    pkgs.git

    pkgs.jellyfin
    pkgs.jellyfin-ffmpeg
    pkgs.jellyfin-web
  ];

  # Disable printing
  services.printing.enable = lib.mkForce false;

  networking.hostName = "nixos-homelab";
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  networking.firewall.allowedUDPPorts = [ 22 80 443 ];
  networking.firewall.enable = true;

  system.stateVersion = "24.05";
}
