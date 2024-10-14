{ pkgs, inputs, ... }: {
  fonts.packages = with pkgs; [
    fira-code
    inputs.apple-fonts.packages.x86_64-linux.sf-mono-nerd
    inputs.apple-fonts.packages.x86_64-linux.sf-pro
    inputs.apple-fonts.packages.x86_64-linux.ny
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [  "New York Medium" ];
      sansSerif = [ "SF Pro" ];
      monospace = [ "SFMono Nerd Font" ];
    };
  };
}
