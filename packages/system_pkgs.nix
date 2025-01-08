{ inputs, pkgs, pinned-pkgs, pkgs-stable, ... }: {
  environment.systemPackages = [
    pkgs.xorg.libXi
    pkgs.xorg.libXtst

    pkgs.dconf-editor

    pkgs.steam-run

    pkgs.nixd
    pkgs.skia
    pkgs.kdePackages.breeze
    pkgs.planify
    pkgs.vlc
    pkgs.signal-desktop
    pkgs.thunderbird
    pkgs.mullvad-vpn
    pkgs.vesktop
    pkgs.obsidian
    pkgs-stable.bruno # Broken on unstable (29 dec 2024)
    pkgs.delfin
    pkgs.qbittorrent
    pkgs.jellyfin-media-player

    # Cli utilities
    pkgs.man-pages
    pkgs.wl-clipboard
    pkgs.man-pages-posix
    pkgs.xdg-utils


    pkgs.g4music

    pinned-pkgs.qgis-ltr

    pkgs.reaper
    pkgs.vital
    pkgs.samplv1

    # Module 9 Stuff
    pkgs.vscode
    pkgs.android-studio
    pkgs.android-tools

    pkgs.lutris
    #pkgs.modrinth-app
    pkgs.prismlauncher
    pkgs.libreoffice
    pkgs.cemu
    pkgs.ungoogled-chromium
    pkgs.jellyfin-media-player


    pkgs.fractal
    pkgs.ryujinx
  ];
}
