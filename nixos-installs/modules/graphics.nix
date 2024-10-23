{ pkgs, ... }: {
  services.xserver.enable = true;
  hardware.graphics.enable = true;

  environment.systemPackages = [
    pkgs.vulkan-loader
    pkgs.mesa
    pkgs.vulkan-headers
    pkgs.vulkan-tools
  ];
}
