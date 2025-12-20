let
  browserDesktopFile = "librewolf.desktop";
in {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "video/mp4" = "vlc.desktop";
      "text/calendar" = "gnome-calendar.desktop";
      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/png" = "org.gnome.Loupe.desktop";
      "image/webp" = "org.gnome.Loupe.desktop";
      "application/x-extension-xht" = browserDesktopFile;
      "image/gif" = "org.gnome.Loupe.desktop";
      "x-scheme-handler/http" = browserDesktopFile;
      "x-scheme-handler/https" = browserDesktopFile;
      "x-scheme-handler/chrome" = browserDesktopFile;
      "text/html" = browserDesktopFile;
      "application/x-extension-htm" = browserDesktopFile;
      "application/x-extension-html" = browserDesktopFile;
      "application/x-extension-shtml" = browserDesktopFile;
      "application/xhtml+xml" = browserDesktopFile;
      "application/x-extension-xhtml" = browserDesktopFile;
      "application/pdf" = "org.gnome.Evince.desktop";
      "inode/directory" = "org.gnome.Nautilus.desktop";
    };
  };
}
