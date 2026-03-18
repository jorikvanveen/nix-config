{ pkgs, ...}: {
  services.wivrn = {
    enable = true;
    openFirewall = true;
    highPriority = true;
  };

  environment.systemPackages = [
      pkgs.android-tools
  ];
}
