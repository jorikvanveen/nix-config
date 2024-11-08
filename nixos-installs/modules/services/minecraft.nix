{ inputs, pkgs, ... }:
let
  minecraftServers =
    inputs.nix-minecraft.legacyPackages.x86_64-linux.minecraftServers;
in {
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  networking.firewall.allowedTCPPorts = [ 25565 ];
  networking.firewall.allowedUDPPorts = [ 25555 ];

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers.epicserver = {
      enable = true;
      restart = "always";
      package = minecraftServers.fabric-1_21_1;
      jvmOpts = "-Xms8G -Xmx8G";
      files = {
        "ops.json" = pkgs.writeTextFile {
          name = "ops.json";
          text = builtins.toJSON [{
            uuid = "faffa28d-50ca-4a16-b1e6-ecc4b50b033c";
            name = "Tobeqz";
            level = 4;
          }];
        };
      };
      serverProperties = {
        motd = "I love NIXOS!!!!";
        difficulty = "hard";
        white-list = true;
        spawn-protection = 0;
        enable-rcon = true;
        "rcon.password" = "lolza";
      };
      whitelist = {
        Tobeqz = "faffa28d-50ca-4a16-b1e6-ecc4b50b033c";
        bigmo48 = "4aeb4419-1f70-4f6a-bd2c-eb65609916ba";
        Wynt = "4aeb2547-abc1-4e13-be0c-e065754aa152";
        VEYRON27787 = "3aabbca0-6bda-404a-96cb-8bbaed351110";
      };
      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
          Chunky = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/fALzjamp/versions/dPliWter/Chunky-1.4.16.jar";
            sha512 =
              "7e862f4db563bbb5cfa8bc0c260c9a97b7662f28d0f8405355c33d7b4100ce05378b39ed37c5d75d2919a40c244a3011bb4ba63f9d53f10d50b11b32656ea395";
          };
          C2ME = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/VSNURh3q/versions/4Dtxhzpd/c2me-fabric-mc1.21.1-0.3.0%2Balpha.0.295.jar";
            sha512 =
              "56a10ced5010c871280f3cdb14e784b8720af8adbd6576b29d0452a3dc770bc56e0600893f4aa5f72a925686112567985be83469c45665855006df94d5236531";
          };
          FabricAPI = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/P7dR8mSH/versions/thGkUOxt/fabric-api-0.107.0%2B1.21.1.jar";
            sha512 =
              "04cf3f205c83882c7c741da392d10cbf9ab471fb44836d753f9673b7b37ddb9b2842cc8e72d6d7f36c48d121715f9f9dae8d20e597f2c0de3bb8abd37037baaa";
          };
          ModernFix = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/nmDcB62a/versions/qO3cN8gB/modernfix-fabric-5.19.5%2Bmc1.21.1.jar";
            sha512 =
              "840c1f0bc2d4b0766c91841ed46d98ef768eb2a4792501660b8ebd8ec59d4b9e0dd96b0ec48558c58a3bf91035ec09d87b386484ff24a15c191372e4ec503579";
          };
          LithiumFabric = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/gvQqBUqZ/versions/2mbrKlX3/lithium-fabric-0.14.0-snapshot%2Bmc1.21.1-build.88.jar";
            sha512 =
              "e7ff451152caa994521736b3144e7b3edc98ffee0e04bb8ce4381eb777d64fac2d4e9edf6928303c2228c02c5d09147d369e71c12b45c39b324daf6916e6d0a1";
          };
          DistantHorizons = pkgs.fetchurl {
            url =
              "https://gitlab.com/distant-horizons-team/distant-horizons/-/jobs/8296050898/artifacts/raw/fabric/build/libs/DistantHorizons-fabric-2.3.0-a-dev-1.21.1.jar";
            sha512 =
              "f62f7194566908d716d81d6551ca008fb05af9edbe35c299c2162951edb092e0419200c15f46293fb49b30c92eea5d023e34832b9c370ab26711fb097391cf5f";
          };
          CarpetMod = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/TQTTVgYE/versions/f2mvlGrg/fabric-carpet-1.21-1.4.147%2Bv240613.jar";
            sha512 =
              "e6f33d13406796a34e7598d997113f25f7bea3e55f9d334b73842adda52b2c5d0a86b7b12ac812d7e758861e3f468bf201c6c710c40162bb79d6818938204151";
          };
        });
      };
    };
  };
}
