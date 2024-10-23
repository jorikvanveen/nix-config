{
  services.syncthing = {
    settings.devices.homelab = {
      id = "HLRBQMW-P4LXAXU-R523QLT-ATNZWGR-MS2GJQY-MQSSYZ6-KPPP3MF-2J26AAC";
      name = "homelab";
    };

    settings.folders.personal.devices = [ "homelab" ];
  };
}
