{ lib, ... }: {
  services.desktopManager.plasma6.enable = true;

  # Fixes conflict with gnome
  programs.ssh.askPassword = lib.mkForce "seahorse";
}
