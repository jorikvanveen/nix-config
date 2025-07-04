{ pkgs, homedir, ... }: {
  home.packages = [ pkgs.bato ];
  home.file.batoconfig = {
    text = ''
tick_rate: 1
critical_level: 5
low_level: 30
critical:
  summary: Critical battery level!
  body: Plug the power cable asap!
  icon: battery-caution
low:
  summary: Battery low
  icon: battery-040
full:
  summary: Battery full
  icon: battery-full
  urgency: Low
charging:
  summary: Battery
  body: Charging
  icon: battery-good-charging
discharging:
  summary: Battery
  body: Discharging
  icon: battery-good
'';
    target = homedir + "/.config/bato/bato.yaml";
  };
}
