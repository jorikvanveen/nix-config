{ lib, ... }: {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/mutter" = {
      check-alive-timeout = 60000;
    };
  };
}
