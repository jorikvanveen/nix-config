{ lib, ... }: {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/desktop/interface" = {
      font-antialiasing = "rgba";
      font-hinting = "slight";
    };
  };
}
