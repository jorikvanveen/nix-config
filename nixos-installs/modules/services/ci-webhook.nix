{ pkgs, ... }: {
  services.webhook = {
    enable = true;
    hooks.deploy-hovyu = {
      execute-command = "${pkgs.nushell}/bin/nu";
      command-working-directory = "/home/main/data/hovyu-scripts";
      pass-arguments-to-command = [
        {
          source = "string";
          name =  "/home/main/data/hovyu-scripts/deploy-hovyu.sh";
        } 
        {
          source = "payload";
          name = "job_id";
        }
      ];
    };
  };

  systemd.services.webhook = {
    serviceConfig = {
      User = pkgs.lib.mkForce "main";
      Group = pkgs.lib.mkForce "users";
    };
    path = [pkgs.nushell pkgs.curl pkgs.zip pkgs.podman];
  };
}

