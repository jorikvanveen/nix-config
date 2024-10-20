{ lib, ... }: {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "us+intl" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };
  };
}
