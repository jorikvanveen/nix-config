{ pkgs, pkgs-yabridge, lib, ... }: let
  #wine = pkgs-yabridge.wine-staging.overrideAttrs (oldAttrs: {
  #  src = fetchTarball {
  #    url = "https://dl.winehq.org/wine/source/9.x/wine-9.21.tar.xz";
  #    sha256 = "sha256:1fc5gq6yhah97i06lpy5anzaydp2xln78pgcgxiwwiyb2098lmwx";
  #  };
  #});
  wine = pkgs.wineWowPackages.yabridge;
in {
  environment.systemPackages = [ 
    pkgs.reaper
    pkgs.vital
    pkgs.samplv1
    pkgs.distrho-ports
    pkgs.carla
    (pkgs.yabridge.override { inherit wine; })
    (pkgs.yabridgectl.override { inherit wine; })
    #(pkgs.yabridge.override { wine = pkgs.wineWowPackages.stagingFull; })
    #(pkgs.yabridgectl.override { wine = pkgs.wineWowPackages.stagingFull; })
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
