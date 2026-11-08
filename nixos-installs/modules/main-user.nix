{ pkgs, ... }: {
  users.users.main = {
    isNormalUser = true;
    description = "Jorik";
    linger = true;
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
      "audio"
      "realtime"
    ];
    #useDefaultShell = true;
  };
}
