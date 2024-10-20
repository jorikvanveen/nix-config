{ lib, ... }: {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer"];
    };
  };
}

