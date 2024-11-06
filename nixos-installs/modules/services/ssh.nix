{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
  };
  services.fail2ban.enable = true;
}
