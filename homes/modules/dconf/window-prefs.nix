
{ lib, ... }: {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/desktop/wm/preferences" = {
      auto-raise = false;
      button-layout = "appmenu:minimize,maximize,close";
      focus-mode = "sloppy";
    };
  };
}
