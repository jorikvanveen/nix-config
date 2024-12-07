{ pkgs, ... }: {
  hardware.graphics.enable = true;
  hardware.nvidia.open = true;

  environment.systemPackages = [ pkgs.cudaPackages.cudatoolkit ];

  services.xserver.videoDrivers = [ "nvidia" ];
}
