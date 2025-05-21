{ lib, ... }: {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/shell" = {
      disabled-extensions = [ "window-list@gnome-shell-extensions.gcampax.github.com" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "launch-new-instance@gnome-shell-extensions.gcampax.github.com" "system-monitor@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "forge@jmmaranan.com" "pomodoro@arun.codito.in" "caffeine@patapon.info" ];
    };
  };
}

