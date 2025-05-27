{ inputs, pkgs, pkgs-stable, ... }: {
  environment.systemPackages = [
    pkgs.xorg.libXi
    pkgs.xorg.libXtst

    pkgs.dconf-editor

    pkgs.steam-run

    pkgs.nixd
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
    pkgs.ffmpeg
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
          categories = [
            "AudioVideo"
            "Audio"
            "Player"
            "Music"
          ];
        })  
      ];
    }))

    # Cli utilities
    pkgs.man-pages
    pkgs.wl-clipboard
    pkgs.man-pages-posix
    pkgs.xdg-utils
    #pkgs.unrar
    pkgs.htop
    pkgs.wget

    pkgs.g4music


    # Module 9 Stuff
    pkgs.vscode
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
    pkgs.uv
  ];
}
