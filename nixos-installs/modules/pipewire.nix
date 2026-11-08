{
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.extraConfig."51-ldac-quality" = {
      "monitor.bluez.rules" = [
        {
          matches = [ { "device.name" = "~bluez_card.*"; } ];
          # Fixed high quality causes recurring clicks with the WH-1000XM4.
          actions.update-props."bluez5.a2dp.ldac.quality" = "sq";
        }
      ];
    };
  };
}
