{
  # Enable the OpenSSH daemon.
  services.openssh = {
    openFirewall = true;
    enable = true;
    allowSFTP = true;
  };
  services.fail2ban.enable = true;
}
