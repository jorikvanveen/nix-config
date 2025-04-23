{ pkgs, pkgs-yabridge, lib, ... }: let
  yabridge = pkgs.wineWowPackages.yabridge;
in {
  environment.systemPackages = [ 
    pkgs.reaper
    pkgs.vital
    pkgs.samplv1
    pkgs.distrho-ports
    pkgs.carla
    yabridge 
    #(pkgs.yabridgectl.override { inherit yabridge; })
 ];

  
  environment.sessionVariables =
      let
        makePluginPath =
        format:
          "$HOME/.${format}:" +
          (lib.makeSearchPath format [
            "$HOME/.nix-profile/lib"
            "/run/current-system/sw/lib"
            "/etc/profiles/per-user/$USER/lib"
            ]);
      in
      {
        CLAP_PATH = lib.mkDefault (makePluginPath "clap");
        DSSI_PATH = lib.mkDefault (makePluginPath "dssi");
        LADSPA_PATH = lib.mkDefault (makePluginPath "ladspa");
        LV2_PATH = lib.mkDefault (makePluginPath "lv2");
        LXVST_PATH = lib.mkDefault (makePluginPath "lxvst");
        VST3_PATH = lib.mkDefault (makePluginPath "vst3");
        VST_PATH = lib.mkDefault (makePluginPath "vst");
      };
}
