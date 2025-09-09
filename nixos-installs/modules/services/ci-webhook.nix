{
  services.webhook = {
    enable = true;
    hooks.deploy-hovyu = {
      execute-command = "/home/main/data/deploy-hovyu.sh";
    };
  };
}

