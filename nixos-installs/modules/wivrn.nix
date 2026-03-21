{ pkgs, ...}: {
  services.wivrn = {
    enable = true;
    openFirewall = true;
    highPriority = true;
  };

  services.lact = {
    enable = true;
  };

  environment.systemPackages = [
      pkgs.android-tools
  ];
}
