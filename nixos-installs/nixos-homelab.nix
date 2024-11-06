{ pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware/nixos-homelab-hardware.nix

    ./modules/syncthing-homelab.nix
    ./modules/systemd-boot.nix
    ./modules/network.nix
    ./modules/locale.nix
    ./modules/x11-keymap.nix
    ./modules/main-user.nix
    ./modules/sops.nix
    ./modules/docker.nix
    ./modules/flake-support.nix

    ./modules/services/atuin.nix
    ./modules/services/jellyfin.nix
    ./modules/services/radarr.nix
    ./modules/services/sonarr.nix
    ./modules/services/prowlarr.nix
    ./modules/services/sabnzbd.nix
    ./modules/services/open-webui.nix
    ./modules/services/caddy.nix
    ./modules/services/nextcloud.nix
    ./modules/services/rust-motd.nix
    ./modules/services/ssh.nix
  ];

  environment.systemPackages = [
    pkgs.neovim
    pkgs.git

    pkgs.jellyfin
    pkgs.jellyfin-ffmpeg
    pkgs.jellyfin-web
  ];

  # Disable printing
  services.printing.enable = false;

  networking.hostName = "nixos-homelab";
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  networking.firewall.allowedUDPPorts = [ 22 80 443 ];

  system.stateVersion = "24.05";
}
