{ inputs, pkgs, pinned-pkgs, ... }: {
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
    pkgs.bruno
    pkgs.delfin
    pkgs.qbittorrent

    # Cli utilities
    pkgs.man-pages
    pkgs.wl-clipboard
    pkgs.man-pages-posix
    pkgs.xdg-utils


    pkgs.g4music

    pinned-pkgs.qgis-ltr

    # Module 9 Stuff
    pkgs.vscode
    pkgs.android-studio
    pkgs.android-tools

    pkgs.lutris
    pkgs.modrinth-app

    pkgs.fractal
    
    inputs.posting-flake.packages.x86_64-linux.posting
  ];
}
