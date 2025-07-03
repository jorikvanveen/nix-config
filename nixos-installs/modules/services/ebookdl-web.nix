{ inputs, pkgs, ... }: let ebookdl-web = inputs.ebookdl-web.packages.x86_64-linux.default; in {
  systemd.services.ebookdl-web = {
    wantedBy = [ "network.target" ];
    script = "${ebookdl-web}/bin/ebookdl";
    path = [ pkgs.libgourou ];
    serviceConfig = {
      Restart = "always";
      RestartSec = "2s";
    };
  };
}
