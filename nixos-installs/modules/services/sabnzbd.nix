{ unstable, ... }: {
  services.sabnzbd = {
    package = unstable.sabnzbd;
    enable = true;
    user = "main";
  };
}
