# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:
with lib.hm.gvariant;
{
  "ca/desrt/dconf-editor" = {
    saved-pathbar-path = "/org/gnome/desktop/wm/keybindings/";
    saved-view = "/org/gnome/desktop/wm/keybindings/";
    window-height = 985;
    window-is-maximized = false;
    window-width = 1904;
  };

  "org/gnome/Console" = {
    last-window-maximised = false;
    last-window-size = mkTuple [ 948 1032 ];
  };

  "org/gnome/Extensions" = {
    window-height = 1032;
    window-width = 948;
  };

  "org/gnome/Geary" = {
    migrated-config = true;
  };

  "org/gnome/calendar" = {
    active-view = "month";
    window-maximized = true;
    window-size = mkTuple [ 768 600 ];
  };

  "org/gnome/control-center" = {
    last-panel = "power";
    window-state = mkTuple [ 948 1032 false ];
  };

  "org/gnome/desktop/app-folders" = {
    folder-children = [ "Utilities" "YaST" "Pardus" ];
  };

  "org/gnome/desktop/app-folders/folders/Pardus" = {
    categories = [ "X-Pardus-Apps" ];
    name = "X-Pardus-Apps.directory";
    translate = true;
  };

  "org/gnome/desktop/app-folders/folders/Utilities" = {
    apps = [ "gnome-abrt.desktop" "gnome-system-log.desktop" "nm-connection-editor.desktop" "org.gnome.baobab.desktop" "org.gnome.Connections.desktop" "org.gnome.DejaDup.desktop" "org.gnome.Dictionary.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.Evince.desktop" "org.gnome.FileRoller.desktop" "org.gnome.fonts.desktop" "org.gnome.Loupe.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.tweaks.desktop" "org.gnome.Usage.desktop" "vinagre.desktop" ];
    categories = [ "X-GNOME-Utilities" ];
    name = "X-GNOME-Utilities.directory";
    translate = true;
  };

  "org/gnome/desktop/app-folders/folders/YaST" = {
    categories = [ "X-SuSE-YaST" ];
    name = "suse-yast.directory";
    translate = true;
  };

  "org/gnome/desktop/input-sources" = {
    sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "us+intl" ]) ];
    xkb-options = [ "terminate:ctrl_alt_bksp" ];
  };

  "org/gnome/desktop/interface" = {
    #color-scheme = "prefer-dark";
    #font-antialiasing = "rgba";
    #font-hinting = "slight";
    #font-name = "SF Pro Display 11";
    #monospace-font-name = "SFMono Nerd Font 11";
    #gtk-theme = "Adwaita";
    #icon-theme = "Adwaita";
    #cursor-theme = "Adwaita";
    gtk-enable-primary-paste = false;
    show-battery-percentage = false;
  };

  "org/gnome/desktop/notifications" = {
    application-children = [ "org-gnome-console" "gnome-power-panel" "firefox" "dev-zed-zed" ];
  };

  "org/gnome/desktop/notifications/application/dev-zed-zed" = {
    application-id = "dev.zed.Zed.desktop";
  };

  "org/gnome/desktop/notifications/application/firefox" = {
    application-id = "firefox.desktop";
  };

  "org/gnome/desktop/notifications/application/gnome-power-panel" = {
    application-id = "gnome-power-panel.desktop";
  };

  "org/gnome/desktop/notifications/application/org-gnome-console" = {
    application-id = "org.gnome.Console.desktop";
  };

  "org/gnome/desktop/peripherals/mouse" = {
    natural-scroll = false;
  };

  "org/gnome/desktop/peripherals/touchpad" = {
    natural-scroll = false;
    tap-to-click = true;
    two-finger-scrolling-enabled = true;
  };

  "org/gnome/desktop/privacy" = {
    old-files-age = mkUint32 30;
    recent-files-max-age = -1;
  };

  "org/gnome/desktop/search-providers" = {
    disable-external = false;
    sort-order = [ "org.gnome.Contacts.desktop" "org.gnome.Documents.desktop" "org.gnome.Nautilus.desktop" ];
  };

  "org/gnome/desktop/session" = {
    idle-delay = mkUint32 300;
  };

  "org/gnome/desktop/wm/preferences" = {
    auto-raise = false;
    button-layout = "appmenu:minimize,maximize,close";
    focus-mode = "sloppy";
  };

  "org/gnome/desktop/wm/keybindings" = {
    switch-to-workspace-left = [ "<Super>Q" ];
    switch-to-workspace-right = [ "<Super>W" ];
    close = ["<Super><Shift>C" ];
    minimize = [ "<Super>m" ];
  };

  "org/gnome/shell/keybindings" = {
    toggle-message-tray = [ ];
  };

  "org/gnome/settings-daemon/plugins/media-keys" = {
    custom-keybindings=[
    	"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
    	"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
		];
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    binding = "<Shift><Super>Return";
    command = "alacritty";
    name = "Open terminal";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
    binding = "<Control><Super>T";
    command = "io.github.alainm23.planify.quick-add";
    name = "Quick add a task";
  };

  "org/gnome/epiphany" = {
    ask-for-default = false;
  };

  "org/gnome/epiphany/state" = {
    is-maximized = false;
    window-size = mkTuple [ 1024 768 ];
  };

  "org/gnome/evolution-data-server" = {
    migrated = true;
  };

  "org/gnome/gnome-system-monitor" = {
    current-tab = "processes";
    show-dependencies = false;
    show-whose-processes = "user";
    window-height = 1032;
    window-width = 948;
  };

  "org/gnome/gnome-system-monitor/disktreenew" = {
    col-6-visible = true;
    col-6-width = 0;
  };

  "org/gnome/mutter" = {
    dynamic-workspaces = false;
    experimental-features = ["scale-monitor-framebuffer"];
  };

  "org/gnome/nautilus/preferences" = {
    default-folder-viewer = "icon-view";
    migrated-gtk-settings = true;
    search-filter-time-type = "last_modified";
  };

  "org/gnome/nautilus/window-state" = {
    initial-size = mkTuple [ 629 1032 ];
  };

  "org/gnome/settings-daemon/plugins/color" = {
    night-light-enabled = true;
  };

  "org/gnome/settings-daemon/plugins/power" = {
    sleep-inactive-ac-type = "nothing";
    sleep-inactive-battery-type = "suspend";
  };

  "org/gnome/shell" = {
    disabled-extensions = [ "window-list@gnome-shell-extensions.gcampax.github.com" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" ];
    enabled-extensions = [ "launch-new-instance@gnome-shell-extensions.gcampax.github.com" "system-monitor@gnome-shell-extensions.gcampax.github.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "forge@jmmaranan.com" "pomodoro@arun.codito.in" ];
    last-selected-power-profile = "performance";
    welcome-dialog-last-shown-version = "46.2";
  };

  "org/gnome/shell/extensions/forge" = {
    css-last-update = mkUint32 37;
    tiling-mode-enabled = true;
    window-gap-hidden-on-single = false;
  };

  "org/gnome/shell/extensions/forge/keybindings" = {
    con-split-horizontal = [ "<Super>z" ];
    con-split-layout-toggle = [ "<Super>g" ];
    con-split-vertical = [ "<Super>v" ];
    con-stacked-layout-toggle = [ "<Shift><Super>s" ];
    con-tabbed-layout-toggle = [ "<Shift><Super>t" ];
    con-tabbed-showtab-decoration-toggle = [ "<Control><Alt>y" ];
    focus-border-toggle = [ "<Super>x" ];
    prefs-tiling-toggle = [ ];
    window-focus-down = [ "<Super>j" ];
    window-focus-left = [ "<Super>h" ];
    window-focus-right = [ "<Super>l" ];
    window-focus-up = [ "<Super>k" ];
    window-gap-size-decrease = [ "<Control><Super>minus" ];
    window-gap-size-increase = [ "<Control><Super>plus" ];
    window-move-down = [ "<Shift><Super>j" ];
    window-move-left = [ "<Shift><Super>h" ];
    window-move-right = [ "<Shift><Super>l" ];
    window-move-up = [ "<Shift><Super>k" ];
    window-resize-bottom-decrease = [ "<Shift><Control><Super>i" ];
    window-resize-bottom-increase = [ "<Control><Super>u" ];
    window-resize-left-decrease = [ "<Shift><Control><Super>o" ];
    window-resize-left-increase = [ "<Control><Super>y" ];
    window-resize-right-decrease = [ "<Shift><Control><Super>y" ];
    window-resize-right-increase = [ "<Control><Super>o" ];
    window-resize-top-decrease = [ "<Shift><Control><Super>u" ];
    window-resize-top-increase = [ "<Control><Super>i" ];
    window-snap-center = [ "<Control><Alt>c" ];
    window-snap-one-third-left = [ "<Control><Alt>d" ];
    window-snap-one-third-right = [ "<Control><Alt>g" ];
    window-snap-two-third-left = [ "<Control><Alt>e" ];
    window-snap-two-third-right = [ "<Control><Alt>t" ];
    window-swap-down = [ "<Control><Super>j" ];
    window-swap-last-active = [ "<Super>Return" ];
    window-swap-left = [ "<Control><Super>h" ];
    window-swap-right = [ "<Control><Super>l" ];
    window-swap-up = [ "<Control><Super>k" ];
    window-toggle-always-float = [ "<Super><Alt>c" ];
    window-toggle-float = [ "<Super>c" ];
    workspace-active-tile-toggle = [ "<Shift><Super>w" ];
  };

  "org/gnome/shell/world-clocks" = {
    locations = [];
  };

  "org/gnome/tweaks" = {
    show-extensions-notice = false;
  };

  "org/gtk/gtk4/settings/file-chooser" = {
    date-format = "regular";
    location-mode = "path-bar";
    show-hidden = false;
    sidebar-width = 140;
    sort-column = "name";
    sort-directories-first = true;
    sort-order = "ascending";
    type-format = "category";
    view-type = "list";
    window-size = mkTuple [ 984 539 ];
  };

  "org/gtk/settings/file-chooser" = {
    date-format = "regular";
    location-mode = "path-bar";
    show-hidden = false;
    show-size-column = true;
    show-type-column = true;
    sidebar-width = 157;
    sort-column = "name";
    sort-directories-first = false;
    sort-order = "ascending";
    type-format = "category";
    window-position = mkTuple [ 26 23 ];
    window-size = mkTuple [ 1231 902 ];
  };
}
