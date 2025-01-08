{ lib, pkgs, ... }: {
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = lib.mkDefault true;
  services.xserver.desktopManager.gnome.enable = lib.mkDefault true;
  environment.systemPackages = [
    pkgs.gnome-tweaks
    pkgs.gnomeExtensions.forge
    pkgs.gnomeExtensions.caffeine
    pkgs.gnome-pomodoro
    pkgs.gsettings-desktop-schemas
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.adwaita-icon-theme
    pkgs.adw-gtk3
    pkgs.protonup-qt
  ];
}
