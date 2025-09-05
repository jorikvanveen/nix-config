{ inputs, pkgs, system, ... }:
let
  pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${system};
  nomouse = inputs.nomouse.packages.${system}.default;
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
    pkgs-stable.planify
    pkgs.vlc
    pkgs.signal-desktop-bin
    pkgs.thunderbird
    pkgs.mullvad-vpn
    pkgs.vesktop
    pkgs.obsidian
    pkgs-stable.bruno # Broken on unstable (29 dec 2024)
    pkgs.delfin
    pkgs.qbittorrent
    pkgs.jellyfin-media-player
    pkgs.feishin
    pkgs.nicotine-plus
    (pkgs.finamp.overrideAttrs (oldAttrs: {
      desktopItems = [
        (pkgs.makeDesktopItem {
          name = "com.unicornsonlsd.finamp";
          desktopName = "Finamp";
          genericName = "Music Player";
          exec = "finamp %U";
          tryExec = "finamp";
          icon = "finamp";
          startupWMClass = "finamp";
          comment = "An open source Jellyfin music player";
          categories = [ "AudioVideo" "Audio" "Player" "Music" ];
        })
      ];
    }))

    # Cli utilities
    pkgs.wl-clipboard
    pkgs.xdg-utils

    pkgs.g4music

    pkgs.vscode
    pkgs.lutris
    pkgs.prismlauncher
    pkgs.libreoffice
    pkgs.cemu
    pkgs.ungoogled-chromium
    pkgs.jellyfin-media-player

    pkgs.fractal
    pkgs.ryujinx
  ];
}
