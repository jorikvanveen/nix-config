{
  inputs,
  pkgs,
  system,
  ...
}:
let
  nomouse = inputs.nomouse.packages.${system}.default;
  desktop-file-query = inputs.desktop-file-query.packages.${system}.default;
in {
  imports = [
    ./modules/calibre.nix
    ./modules/audacity.nix
    ./modules/bottles.nix
    ./modules/graphics.nix
    ./modules/bluetooth.nix
    ./modules/systemd-boot.nix
    ./modules/spicetify.nix
    ./modules/mullvad.nix
    ./modules/fix-java-fonts.nix
    ./modules/steam.nix
    ./modules/gamemode.nix
    ./modules/pipewire.nix
    ./modules/niri.nix
    ./modules/geoclue.nix
    ./modules/gamescope.nix
    ./modules/services/ratbagd.nix
  ];
  environment.systemPackages = [
    nomouse
    pkgs.xorg.libXi
    pkgs.xorg.libXtst
    pkgs.dconf-editor
    pkgs.steam-run
    pkgs.skia
    pkgs.kdePackages.breeze
    pkgs.vlc
    pkgs.signal-desktop
    pkgs.thunderbird
    pkgs.mullvad-vpn
    pkgs.vesktop
    pkgs.obsidian
    pkgs.delfin
    pkgs.qbittorrent
    pkgs.feishin
    pkgs.nicotine-plus
    pkgs.gimp
    pkgs.bluetuith
    pkgs.pulsemixer

    # Cli utilities
    pkgs.wl-clipboard
    pkgs.xdg-utils

    pkgs.gapless

    pkgs.vscode
    pkgs.lutris
    pkgs.prismlauncher
    pkgs.libreoffice
    pkgs.ungoogled-chromium

    pkgs.monero-gui
    pkgs.electrum

    pkgs.librewolf
    
    desktop-file-query

    pkgs.cryptomator
    pkgs.filezilla
  ];
}
