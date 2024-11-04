{ inputs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware/nixos-homelab-hardware.nix

    ./modules/syncthing-homelab.nix
    ./modules/systemd-boot.nix
    ./modules/network.nix
    ./modules/locale.nix
    ./modules/x11-keymap.nix
    ./modules/main-user.nix
    ./modules/unfree-allow.nix

    ./modules/services/atuin.nix
    ./modules/services/jellyfin.nix
    ./modules/services/radarr.nix
    ./modules/services/sonarr.nix
    ./modules/services/prowlarr.nix
    ./modules/services/sabnzbd.nix
    ./modules/services/open-webui.nix
    ./modules/services/caddy.nix

    ./modules/sops.nix
  ];

  # Disable printing
  services.printing.enable = false;

  networking.hostName = "nixos-homelab";

  system.stateVersion = "24.05";
}
