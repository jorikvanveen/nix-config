{ pkgs, zen_flake, ... }: {
  environment.systemPackages = [
    pkgs.gnome-tweaks
    pkgs.gnomeExtensions.forge
    pkgs.gnome-pomodoro
    pkgs.gsettings-desktop-schemas
    pkgs.dconf-editor

    pkgs.alacritty
    pkgs.nixd
    pkgs.steam-run
    pkgs.skia
    pkgs.adwaita-icon-theme
    pkgs.kdePackages.breeze
    pkgs.protonup-qt
    pkgs.planify
    pkgs.vlc
    pkgs.signal-desktop
    pkgs.thunderbird
    pkgs.mullvad-vpn
    pkgs.qbittorrent

    # Cli utilities
    pkgs.man-pages
    pkgs.wl-clipboard
    pkgs.man-pages-posix

    # Vulkan stuff
    pkgs.vulkan-loader
    pkgs.mesa
    pkgs.vulkan-headers
    pkgs.vulkan-tools

    pkgs.g4music

    pkgs.qgis-ltr

    # Module 9 Stuff
    pkgs.vscode
    pkgs.android-studio
    pkgs.android-tools

    pkgs.lutris
    zen_flake.default
  ];
}
