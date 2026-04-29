{
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "9999999";
    }
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "9999999";
    }
  ];

  #systemd.services."user@1000".serviceConfig.LimitNOFILE = "9999999";
  systemd.user.extraConfig = "DefaultLimitNOFILE=9999999";
  #systemd.extraConfig = "DefaultLimitNOFILE=9999999";
  systemd.settings.Manager = {
    DefaultLimitNOFILE = 9999999;
  };
}
