{ pkgs, zen_flake, zenpkgs, pinned-pkgs, ... }: {
  environment.systemPackages = [
    pkgs.gnome-tweaks
    pkgs.gnomeExtensions.forge
    pkgs.gnome-pomodoro
    pkgs.gsettings-desktop-schemas
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.dconf-editor

    pkgs.nixd
    pkgs.steam-run
    pkgs.mangohud
    pkgs.skia
    pkgs.adwaita-icon-theme
    pkgs.adw-gtk3
    pkgs.kdePackages.breeze
    pkgs.protonup-qt
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

    # Vulkan stuff
    pkgs.vulkan-loader
    pkgs.mesa
    pkgs.vulkan-headers
    pkgs.vulkan-tools

    pkgs.g4music

    pinned-pkgs.qgis-ltr

    # Module 9 Stuff
    pkgs.vscode
    pkgs.android-studio
    pkgs.android-tools

    pkgs.lutris

    zen_flake.packages.x86_64-linux.default
    #zenpkgs.legacyPackages.x86_64-linux.zen-browser
  ];
}
