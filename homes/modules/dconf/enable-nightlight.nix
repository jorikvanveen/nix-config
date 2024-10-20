{ lib, ... }: {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
    };
  };
}
