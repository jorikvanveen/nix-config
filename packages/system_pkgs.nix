{ pkgs, zen_flake, zenpkgs, pinned-pkgs, ... }: {
  environment.systemPackages = [
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
    pkgs.brave
    pkgs.bruno
    pkgs.delfin

    # Cli utilities
    pkgs.man-pages
    pkgs.wl-clipboard
    pkgs.man-pages-posix


    pkgs.g4music

    pinned-pkgs.qgis-ltr

    # Module 9 Stuff
    pkgs.vscode
    pkgs.android-studio
    pkgs.android-tools

    pkgs.lutris

    #zen_flake.packages.x86_64-linux.default
    zenpkgs.legacyPackages.x86_64-linux.zen-browser
  ];
}
