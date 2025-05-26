{ inputs, ... }: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ../../secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/main/.config/sops/age/keys.txt";
  sops.secrets = {
    anthropic-key = {};
    rdt-client-pw = {};
    vaultwarden-token = {};
    hoarder-nextauth-secret = {};
    hoarder-meili-master = {};
    hoarder-openai-key = {};
    spottarr-usenet-name = {};
    spottarr-usenet-pw = {};
    radicale-htpasswd = {
      owner = "radicale";
    };
    radicale-password = {};
  };
}

