{ inputs, pkgs, system, ... }:
let
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
    pkgs.bruno
    pkgs.delfin
    pkgs.qbittorrent
    pkgs.feishin
    pkgs.nicotine-plus
    pkgs.gimp
    pkgs.bluetuith
    pkgs.pulsemixer
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

    pkgs.gapless

    pkgs.vscode
    pkgs.lutris
    pkgs.prismlauncher
    pkgs.libreoffice
    pkgs.ungoogled-chromium

    pkgs.monero-gui
    pkgs.electrum
    
    pkgs.librewolf
  ];
}
