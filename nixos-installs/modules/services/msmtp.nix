{
  services.msmtp = {
    enable = true;
    setSendmail = true;
    accounts = {
      default = {
        auth = false;
        host = "127.0.0.1";
      };
    };
  };

  services.mailpit.instances = [{
    smtp = "127.0.0.1:1025";
    listen = "127.0.0.1:8025";
  }];
}
