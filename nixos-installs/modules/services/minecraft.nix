{ inputs, ... }:
let
  minecraftServers =
    inputs.nix-minecraft.legacyPackages.x86_64-linux.minecraftServers;
in {
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  servers.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    
    servers.epicserver = {
      enable = true;
      restart = "always";
      package = minecraft-servers.fabric-1-21-3;
    };
  };
}
