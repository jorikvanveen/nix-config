{ pkgs, ... }: {
  specialisation.gamescope.configuration = {
    system.nixos.tags = [ "gamescope" ];

    services.xserver.desktopManager.gnome.enable = false;
    services.xserver.displayManager.gdm.enable = false;

    boot.kernelParams = [ "video=HDMI-A-1:d" ]; # Disable second display
    boot.kernelPackages = pkgs.linuxPackages; # (this is the default) some amdgpu issues on 6.10

    programs = {
      gamescope = {
        enable = true;
        capSysNice = true;
      };
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
    };
    hardware.xone.enable = true; # support for the xbox controller USB dongle
    services.getty.autologinUser = "main";
    environment = {
      loginShellInit = ''
        [[ "$(tty)" = "/dev/tty1" ]] && ./gs.sh
      '';
    };
  };
}
