{ pkgs, ...}: {
  services.wivrn = {
    enable = true;
    openFirewall = true;
    highPriority = true;
    config.enable = true;
    config.json = {
      application = [ pkgs.wayvr ];
    };
  };

  services.lact = {
    enable = true;
  };

  environment.systemPackages = [
      pkgs.android-tools
  ];
}
