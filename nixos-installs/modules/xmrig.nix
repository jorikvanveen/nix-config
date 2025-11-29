{ pkgs, ... }:
{
  services.xmrig = {
    enable = true;
    settings = {
      autosave = true;
      cpu = {
        enabled = true;
        asm = true;
        huge-pages = true;
        priority = 1; 
        max-threads-hint = 60;
      };
      opencl = false;
      cuda = false;
      pools = [
        {
          url = "pool.hashvault.pro:443";
          user = "88H1vXVWLNufsuAPu9YNBMXTEqj65G7gZQrNrwYkMjRZJXseCeXE8dWW7r6VUs6o9gGZdEF5zG8q6AsPJNeMbKwW2hS4o2h";
          pass = "laptop-homelab";
          tls-fingerprint = "420c7850e09b7c0bdcf748a7da9eb3647daf8515718f36d9ccfdd6b9ff834b14";
          keepalive = true;
          tls = true;
        }
      ];
    };
  };
}
