{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    #package = pkgs.steam.override {
    #  extraPkgs = pkgs': with pkgs'; [
    #    xorg.libXcursor
    #    xorg.libXi
    #    xorg.libXinerama
    #    xorg.libXScrnSaver
    #    libpng
    #    libpulseaudio
    #    libvorbis
    #    stdenv.cc.cc.lib # Provides libstdc++.so.6
    #    libkrb5
    #    keyutils
    #    # Add other libraries as needed
    #  ];
    #};
  };

  hardware.xone.enable = true;

  environment.systemPackages = [ pkgs.mangohud pkgs.gamescope ];
}
