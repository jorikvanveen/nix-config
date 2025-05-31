{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  pname = "org-bullets.nvim";
  version = "1.0.0"; # TODO
  src = pkgs.fetchFromGitHub {
    owner = "nvim-orgmode";
    repo = "org-bullets.nvim";
    rev = "21437cfa99c70f2c18977bffd423f912a7b832ea";
    hash = "sha256-/l8IfvVSPK7pt3Or39+uenryTM5aBvyJZX5trKNh0X0=";

  };
  buildPhase = ''
    ls .
    mkdir $out
    cp -r ./* $out/
  '';
}
