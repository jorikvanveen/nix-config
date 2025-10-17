{ pkgs, lib, inputs, ... }:
let
  xwayland-satellite = pkgs.xwayland-satellite;
  ags-bar = inputs.ags-shell.packages.x86_64-linux.default;
in {
  programs.niri.enable = true;
  services.xserver.displayManager.gdm.enable = lib.mkDefault true;
  services.gvfs.enable = true;
  services.blueman.enable = true;
  services.gnome.evolution-data-server.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.gnome-keyring.enable = true;
  systemd.user.services.ags-bar = {
    wantedBy = [ "graphical-session.target" ];
    script = "${ags-bar}/bin/my-shell";
    path = [ pkgs.bash pkgs.niri pkgs.ffmpeg pkgs.jack_capture pkgs.gvfs pkgs.swaylock ];
    serviceConfig = {
      Restart = "always";
      RestartSec = "2s";
    };
  };
  systemd.user.services.swaybg = {
    wantedBy = [ "graphical-session.target" ];
    script = "${pkgs.swaybg}/bin/swaybg -i ${../wallpapers/epic-rock.jpg} -m fill";
    serviceConfig = {
      Restart = "always";
      RestartSec = 2;
    };
  };
  environment.systemPackages = [
    pkgs.fuzzel
    pkgs.swaylock
    xwayland-satellite
    pkgs.pavucontrol
    pkgs.swaybg

    ## Nice stuff from GNOME
    pkgs.evince # pdfs
    pkgs.nautilus # file manager
    pkgs.decibels # audio file player
    pkgs.celluloid # video player
    pkgs.gnome-characters
    pkgs.gnome-font-viewer
    pkgs.gnome-calendar
    pkgs.gnome-control-center
    pkgs.gnome-weather
    pkgs.gnome-online-accounts
    pkgs.gnome-online-accounts-gtk
    pkgs.dunst
    pkgs.bato
    pkgs.wdisplays # display configuration
  ];
  services.dbus.packages = [
    pkgs.gnome-online-accounts
  ];
}
