{ pkgs, ... }: {
  services.webhook = {
    enable = true;
    hooks.deploy-hovyu = {
      execute-command = "/home/main/data/deploy-hovyu.sh";
    };
  };

  systemd.services.webhook = {
    serviceConfig = {
      User = pkgs.lib.mkForce "main";
      Group = pkgs.lib.mkForce "users";
    };
  };
}

