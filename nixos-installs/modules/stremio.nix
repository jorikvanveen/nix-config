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

    }))
  ];
}
