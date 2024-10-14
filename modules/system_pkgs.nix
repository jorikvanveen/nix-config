{ pkgs }: [
  pkgs.gnome-tweaks
  pkgs.gnomeExtensions.forge
  pkgs.gnomeExtensions.cronomix
  pkgs.gsettings-desktop-schemas
  pkgs.dconf-editor

  pkgs.zed-editor
  pkgs.alacritty
  pkgs.nixd
  pkgs.steam-run
  pkgs.skia
  pkgs.adwaita-icon-theme
  pkgs.kdePackages.breeze
  pkgs.brave
  pkgs.blueman
  pkgs.calibre
  pkgs.errands
  pkgs.gnome-pomodoro
  pkgs.protonup-qt
  pkgs.planify
  pkgs.vlc
  pkgs.signal-desktop
  pkgs.thunderbird
  pkgs.mutter
  pkgs.mullvad-vpn
  pkgs.qbittorrent

  # Cli utilities
  pkgs.ripgrep
  pkgs.jq
  pkgs.tmux
  pkgs.file
  pkgs.neovim
  pkgs.git
  pkgs.wl-clipboard
  pkgs.man-pages
  pkgs.man-pages-posix


  # Vulkan stuff
  pkgs.vulkan-loader
  pkgs.mesa
  pkgs.vulkan-headers
  pkgs.vulkan-tools

  pkgs.nicotine-plus
  pkgs.g4music

  pkgs.qgis-ltr
  pkgs.qbittorrent

  pkgs.obsidian
  pkgs.distrobox

  # Module 9 Stuff
  pkgs.vscode
  pkgs.jetbrains.idea-ultimate
  pkgs.qtspim
  pkgs.android-studio
  pkgs.android-tools
]
