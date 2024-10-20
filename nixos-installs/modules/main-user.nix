{ pkgs, ... }: {
  users.users.main = {
    isNormalUser = true;
    description = "Jorik";
    extraGroups = [ "networkmanager" "wheel" "gamemode" "kvm" "docker" ];
    shell = pkgs.nushell;
    useDefaultShell = true;
  };
}
