{ inputs, ... }: {
  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    autoStart = true;
    package = inputs.sunshine-vlk-flake.packages.x86_64-linux.sunshine;
  };
}
