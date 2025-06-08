{
  imports = [
    ./modules/stylix.nix
    ./modules/niri.nix
    ./modules/zed.nix
    ./modules/mime-associations.nix
    ./modules/ghostty.nix
    ./modules/kodi.nix
    ./modules/heroic.nix
    ./modules/moonlight.nix
    ./modules/additional-fonts.nix
    ./modules/logseq.nix
    ./modules/bato.nix
    ./modules/gammastep.nix

    ./modules/dconf/enable-nightlight.nix
    ./modules/dconf/extensions.nix
    ./modules/dconf/font-rendering.nix
    ./modules/dconf/fractional-scaling.nix
    ./modules/dconf/keybinds.nix
    ./modules/dconf/keyboard-layout.nix
    ./modules/dconf/no-middle-click-paste.nix
    ./modules/dconf/window-prefs.nix
    ./modules/dconf/mutter-alive-timeout.nix
  ];
}
