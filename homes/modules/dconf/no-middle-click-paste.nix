{ lib, ... }: {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/desktop/interface" = {
      gtk-enable-primary-paste = false;
    };
  };
}
