{...} @ inputs: {
  home = {
    username = "main";
    homeDirectory = "/home/main";
    stateVersion = "24.05";
  };

  programs.git = {
    enable = true;
    userEmail = "test@test.org";
    userName = "test";
  };

  programs.home-manager.enable = true;
}
