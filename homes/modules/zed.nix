{ pkgs, system, homedir, dotfiledir, config, ... }: let 
  zed = (pkgs.zed-editor.overrideAttrs (final: old: {
      version = "1.19.0-pre";
      src = pkgs.fetchFromGitHub {
        owner = "zed-industries";
        repo = "zed";
        tag = "v1.19.0-pre";
        hash = "sha256-aQ4TV/1VV3s9A0/UOLVPn06llOFOdkGIMhXWJ8Ycwic=";
      };
      cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
         src = final.src;
         hash = "sha256-PoiKRoUsb8mTfkPPOMAimHEML6vfCbcdGcLwDY7H/cA=";
       };
    }));
in {
  home.file.zed-keymap = {
    target = homedir + "/.config/zed/keymap.json";
    source = config.lib.file.mkOutOfStoreSymlink dotfiledir
      + "/zed/keymap.json";
  };
  home.file.zed-settings = {
    target = homedir + "/.config/zed/settings.json";
    source = config.lib.file.mkOutOfStoreSymlink dotfiledir
      + "/zed/settings.json";
  };

  home.packages = [
    zed
     pkgs.bubblewrap ];
}
