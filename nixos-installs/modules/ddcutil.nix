{ pkgs, ... }: {
  hardware.i2c.enable = true;

  environment.systemPackages = with pkgs; [
    ddcutil
  ];

  users.extraGroups.i2c.members = [ "main" ] ;
}
