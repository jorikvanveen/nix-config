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
      "podman"
      "caddy"
      "minecraft"
      "fuse"
    ];
    shell = pkgs.nushell;
    useDefaultShell = true;
  };
}
