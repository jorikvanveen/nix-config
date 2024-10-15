{ pkgs, homedir, spicetify-nix, ... }: {
  imports = [
    #spicetify-nix.homeManagerModules.default
    ./modules/git.nix
    ./modules/carapace.nix
    ./modules/starship.nix
    ./modules/nushell.nix
    ./modules/direnv.nix
    ./modules/custom_lsd.nix
    ./modules/alacritty.nix
    ./modules/stylix.nix
    #./modules/spotify.nix
    ../packages/home_pkgs.nix
  ];

  home.file.zed = {
    enable = true;
    source = ../program-config/zed;
    target = homedir + "/.config/zed";
    recursive = true;
  };

  programs.bash.enable = true;
}
