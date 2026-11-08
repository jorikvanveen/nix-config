# nomouse needs rw access to /dev/uinput to create virtual devices
{ ... }: {
  users.groups.mouseless = { };
  users.users.main.extraGroups = [ "mouseless" ];
  services.udev.extraRules = ''
    # Output: Virtual device creation
    KERNEL=="uinput", GROUP:="mouseless", MODE:="0660"
  '';
}
