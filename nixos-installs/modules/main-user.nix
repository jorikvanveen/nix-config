{ pkgs, ... }: {
  users.users.main = {
    isNormalUser = true;
    description = "Jorik";
    extraGroups = [
      "networkmanager"
      "render"
      "video"
      "input"
      "wheel"
      "gamemode"
      "kvm"
      "docker"
      "caddy"
      "minecraft"
    ];
    shell = pkgs.nushell;
    useDefaultShell = true;
  };
}
