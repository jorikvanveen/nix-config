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
    (pkgs.delfin.overrideAttrs (oldAttrs: {
      src = pkgs.fetchgit {
        url = "https://codeberg.org/avery42/delfin.git";
        rev = "0ef59d14a8636d7c2c1fe4958d8fb5925020334c";
        hash = "sha256-KPg4ujhYUnQ43iOxetdUC++mgFsSTEUHUt33UsdtA+4=";
      };
    }))
    pkgs.qbittorrent

    # Cli utilities
    pkgs.man-pages
    pkgs.wl-clipboard
    pkgs.man-pages-posix
    pkgs.xdg-utils


    pkgs.g4music

    pinned-pkgs.qgis-ltr

    pkgs.reaper
    pkgs.vital

    # Module 9 Stuff
    pkgs.vscode
    pkgs.android-studio
    pkgs.android-tools

    pkgs.lutris
    pkgs.modrinth-app
    pkgs.prismlauncher
    pkgs.libreoffice


    pkgs.fractal
    pkgs.ryujinx
    inputs.posting-flake.packages.x86_64-linux.posting
  ];
}
