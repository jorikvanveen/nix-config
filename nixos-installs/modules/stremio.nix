{ pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.stremio.overrideAttrs (oldAttrs:  rec {
      version = "5.0.0-b.13";

      src = pkgs.fetchFromGitHub {
         owner = "Stremio";
         repo = oldAttrs.pname;
         rev = "v${version}";
         fetchSubmodules = true;
         sha256 = "";
      };

      server = pkgs.fetchurl {
        url = "https://s3-eu-west-1.amazonaws.com/stremio-artifacts/four/v${version}/server.js";
        sha256 = "";
      };
    }))
  ];
}
