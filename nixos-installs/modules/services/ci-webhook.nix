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
# [Unit]
# After=network.target
# Description=Webhook service
# 
# [Service]
# ExecStart=/nix/store/3k3zm9pykydhzn3qzag72hii4x9rihgs-unit-script-webhook-start/bin/webhook-start
# Group=users
# Restart=on-failure
# SupplementaryGroups=podman
# User=main
# 
# [Install]
# WantedBy=multi-user.target

  systemd.services.user.webhook = {
    serviceConfig = {
      User = pkgs.lib.mkForce "main";
      Group = pkgs.lib.mkForce "users";
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
