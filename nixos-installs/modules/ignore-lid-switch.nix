{
  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";
  services.upower = {
    enable = true;
    ignoreLid = true;
  };
}
