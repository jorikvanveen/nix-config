{ inputs, ... }: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ../../secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/main/.config/sops/age/keys.txt";
  sops.secrets.anthropic-key = {};
}
