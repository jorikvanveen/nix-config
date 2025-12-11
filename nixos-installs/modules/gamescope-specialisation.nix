{ lib, pkgs, ... }: {
  specialisation.gamescope.configuration = {
    imports = [
      ./kde.nix
    ];
    system.nixos.tags = [ "gamescope" ];

    services.xserver.desktopManager.gnome.enable = lib.mkForce false;
    services.xserver.displayManager.gdm.enable = lib.mkForce false;

    #boot.kernelPackages = pkgs.linuxPackages; # (this is the default) some amdgpu issues on 6.10
    #hardware.xone.enable = true; # support for the xbox controller USB dongle
  };
}
