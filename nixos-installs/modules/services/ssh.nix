{ pkgs-stable, ... }: {
  # Enable the OpenSSH daemon.
  services.openssh = {
    openFirewall = true;
    package = pkgs-stable.openssh;
    enable = true;
  };
  services.fail2ban.enable = true;
}
