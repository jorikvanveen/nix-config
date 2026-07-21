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
    ./modules/helium.nix
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
      #((pkgs.vesktop.overrideAttrs {
      #  src = pkgs.fetchFromGitHub {
      #    owner = "Vencord";
      #    repo = "Vesktop";
      #    rev = "29c11f3191d8bd8d1e3ba6fecee4c3e880181dd6";
      #    hash = "sha256-XqdLYGqIyohNheK9qXpap2hZ8ejhB66WdrYB6FReVLk=";
      #  };
      #}).override {
      #    pnpm_10_29_2 = pkgs.pnpm;
      #})
    pkgs.discord
    pkgs.obsidian
    pkgs.delfin
    pkgs.qbittorrent
    pkgs.feishin
    pkgs.nicotine-plus
    pkgs.gimp
    pkgs.bluetuith
    pkgs.pulsemixer
    pkgs.qalculate-gtk

    # Cli utilities
    pkgs.wl-clipboard
    pkgs.xdg-utils

    pkgs.gapless

    pkgs.vscode
    pkgs.prismlauncher
    pkgs.libreoffice
    pkgs.ungoogled-chromium

    pkgs.monero-gui
    pkgs.electrum
    
    desktop-file-query

    pkgs.cryptomator
    pkgs.filezilla
    inputs.optiscaler-client.packages.${system}.default
    pkgs.steam-devices-udev-rules
    pkgs.libusb1
    pkgs.hidapi
    pkgs.extest
  ];
}
