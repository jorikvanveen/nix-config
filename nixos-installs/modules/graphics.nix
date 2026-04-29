{ pkgs, ... }: {
  services.xserver.enable = true;
  hardware.graphics.enable = true;

  environment.systemPackages = [
    pkgs.vulkan-loader
    pkgs.vulkan-headers
    pkgs.vulkan-tools
  ];
}
