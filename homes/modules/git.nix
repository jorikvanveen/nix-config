{
  programs.git = {
    enable = true;
    userEmail = "vanveenjorik@protonmail.com";
    userName = "Jorik";
    extraConfig = {
      pull.rebase = false; # Merge instead of rebase
    };
  };
}
