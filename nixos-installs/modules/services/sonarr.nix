{ pkgs, utils, ... }: {
  services.sonarr = {
    enable = true;
    #package = pkgs.sonarr;
    user = "main";
    group = "users";
    dataDir = "/home/main/data/sonarr";
  };

  systemd.services.sonarr-4k = {
    description = "Sonarr 4k";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      User = "main";
      Group = "users";
      ExecStart = utils.escapeSystemdExecArgs [
        (pkgs.lib.getExe pkgs.sonarr)
        "-nobrowser"
        "-data=/home/main/data/sonarr-4k"
      ];
      Restart = "on-failure";
    };
  };

  # Requred to use sonarr at all as of 8 jan 2025 (yikes)
  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
  ];

}
