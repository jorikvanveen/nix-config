{
  nix.settings = {
    extra-substituters = [
      "ssh://main@nixos-pc.local?trusted=1&ssh-key=/home/main/.ssh/id_ed25519"
    ];
    connect-timeout = 5;
  };

  programs.ssh.knownHosts.nixos-pc = {
    hostNames = [ "nixos-pc.local" ];
    publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEo+FPfwQEnkbiSTzC3KjpDCwzlna9m+vVbAnxTH/oXO";
  };
}
