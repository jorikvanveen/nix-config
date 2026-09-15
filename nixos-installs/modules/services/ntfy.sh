{
  services.ntfy-sh = {
    enable = true;
    settings = {
      listen-http = "127.0.0.1:2586";
      auth-default-access = "deny-all";
      base-url = "https://ntfy.jorik-dev.com";
      auth-users = [
        "jorik:\$2a\$10\$c8MMH9EISrriizARdwSuluihV8Wsn7znh4fdgiDsC8Sbv/76f.0Xi:admin"
        "jorik-regular:\$2a\$10\$7J.JLhbIEfrgyj70mBQuc.DNhp4MOxDYWwjnkLK39cRWZyZOsOcKO:user"
      ];
      auth-access = [
        "jorik-regular:phone-notifications:rw"
      ];
    };
  };

  services.caddy.virtualHosts."ntfy.jorik-dev.com".extraConfig = ''
    reverse_proxy http://localhost:2586
  '';
}
