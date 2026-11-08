{
  programs.git = {
    enable = true;
    settings = {
      user.email = "vanveenjorik@protonmail.com";
      user.name = "Jorik";
      pull.rebase = false; # Merge instead of rebase
      push.autoSetupRemote = true;
    };
  };
}
