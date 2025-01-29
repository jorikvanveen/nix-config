{ pkgs, ... }: {
  home.packages = [
    pkgs.zip
    pkgs.unzip
    pkgs.p7zip
  ];
}
