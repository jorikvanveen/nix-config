{ pkgs, ...} @ inputs: {
  home = {
    username = "main";
    homeDirectory = "/home/main";
    stateVersion = "24.05";
  };

  programs.git = {
    enable = true;
    userEmail = "vanveenjorik@protonmail.com";
    userName = "Jorik";
  };

  programs.home-manager.enable = true;
}
