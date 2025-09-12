{ pkgs, ... }:
{
  services.webhook = {
    enable = true;
    hooks.deploy-hovyu = {
      execute-command = "/home/main/data/hovyu-scripts/deploy-hovyu.sh";
      command-working-directory = "/home/main/data/hovyu-scripts";
      pass-arguments-to-command = [
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
      SupplementaryGroups = [ "podman" ];
    };
    path = [
      pkgs.nushell
      pkgs.curl
      pkgs.zip
      pkgs.podman
      pkgs.unzip
      pkgs.su
      pkgs.slirp4netns
      pkgs.shadow
    ];
  };
}
