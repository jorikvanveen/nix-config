{ pkgs, homedir, ... }: {
  imports = [
    ./modules/git.nix
    ./modules/carapace.nix
    ./modules/starship.nix
    ./modules/nushell.nix
    ./modules/direnv.nix
    ../packages/home_pkgs.nix
    ./modules/custom_lsd.nix
  ];

  home.file.zed = {
    enable = true;
    source = ../program-config/zed;
    target = homedir + "/.config/zed";
    recursive = true;
  };

  programs.bash.enable = true;
}
