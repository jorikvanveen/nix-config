{ lib, ... }: {
  dconf.settings."org/gnome/desktop/wm/keybindings".close = lib.mkForce ["<Super><Shift>X" ];
}
