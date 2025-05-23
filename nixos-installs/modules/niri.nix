{ pkgs, lib, ... }: {
  programs.niri.enable = true;
  programs.waybar.enable = true;
  services.xserver.displayManager.gdm.enable = lib.mkDefault true;
  environment.systemPackages =
    [ pkgs.fuzzel pkgs.swaylock pkgs.xwayland-satellite ];
}
