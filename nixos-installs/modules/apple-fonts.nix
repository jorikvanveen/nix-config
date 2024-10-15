{ pkgs, apple-fonts, ... }: {
  fonts.packages = with pkgs; [
    fira-code
    apple-fonts.packages.x86_64-linux.sf-mono-nerd
    apple-fonts.packages.x86_64-linux.sf-pro
    apple-fonts.packages.x86_64-linux.ny
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [  "New York Medium" ];
      sansSerif = [ "SF Pro" ];
      monospace = [ "SFMono Nerd Font" ];
    };
  };
}
