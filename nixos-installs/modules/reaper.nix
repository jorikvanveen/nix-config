{ pkgs, pkgs-yabridge, lib, ... }: let
  #wine = pkgs-yabridge.wine-staging.overrideAttrs (oldAttrs: {
  #  src = fetchTarball {
  #    url = "https://dl.winehq.org/wine/source/9.x/wine-9.21.tar.xz";
  #    sha256 = "sha256:1fc5gq6yhah97i06lpy5anzaydp2xln78pgcgxiwwiyb2098lmwx";
  #  };
  #});
  wine = pkgs-yabridge.wineWowPackages.yabridge;
in {
  environment.systemPackages = [ 
    (pkgs.reaper.overrideAttrs (oldAttrs: {
        installPhase = ''
          runHook preInstall

          HOME="$out/share" XDG_DATA_HOME="$out/share" ./install-reaper.sh \
            --install $out/opt \
            --integrate-user-desktop
          rm $out/opt/REAPER/uninstall-reaper.sh

          # Dynamic loading of plugin dependencies does not adhere to rpath of
          # reaper executable that gets modified with runtimeDependencies.
          # Patching each plugin with DT_NEEDED is cumbersome and requires
          # hardcoding of API versions of each dependency.
          # Setting the rpath of the plugin shared object files does not
          # seem to have an effect for some plugins.
          # We opt for wrapping the executable with LD_LIBRARY_PATH prefix.
          # Note that libcurl and libxml2 are needed for ReaPack to run.
          wrapProgram $out/opt/REAPER/reaper \
            --prefix LD_LIBRARY_PATH : "${
              with pkgs; lib.makeLibraryPath [
                gtk3
                gtk4
                curl
                lame
                libxml2
                ffmpeg
                vlc
                xdotool
                stdenv.cc.cc
              ]
            }"

          mkdir $out/bin
          ln -s $out/opt/REAPER/reaper $out/bin/

          runHook postInstall
        '';
    }))
    pkgs.vital
    pkgs.samplv1
    pkgs.distrho-ports
    pkgs.carla
    #pkgs.reaper-sws-extension
    #pkgs.reaper-reapack-extension
    (pkgs-yabridge.yabridge.override { inherit wine; })
    (pkgs-yabridge.yabridgectl.override { inherit wine; })
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
