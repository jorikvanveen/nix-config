{ homedir, pkgs, ... }: {
  home.file.sws-extension = {
    source = "${pkgs.reaper-sws-extension}/UserPlugins/reaper_sws-x86_64.so";
    target = "${homedir}/.config/REAPER/UserPlugins/reaper_sws-x86_64.so";
  };

  home.file.sws-script1 = {
    source = "${pkgs.reaper-sws-extension}/Scripts/sws_python.py";
    target = "${homedir}/.config/REAPER/Scripts/sws_python.py";
  };
  
  home.file.sws-script2 = {
    source = "${pkgs.reaper-sws-extension}/Scripts/sws_python64.py";
    target = "${homedir}/.config/REAPER/Scripts/sws_python64.py";
  };

  home.file.reapack = {
    source = "${pkgs.reaper-reapack-extension}/UserPlugins/reaper_reapack-x86_64.so";
    target = "${homedir}/.config/REAPER/UserPlugins/reaper_reapack-x86_64.so";
  };
}
