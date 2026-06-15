{ pkgs, ... }: {
  services.udev.extraRules = ''
    SUBSYSTEM=="tty", KERNEL=="ttyACM*", ATTRS{idVendor}=="346e", ACTION=="add", MODE="0666", TAG+="uaccess"
    # Copyright (c) 2025, Tomasz Pakuła Using Arch BTW
    
    # Add uaccess tag to every Moza (Gudsen) ttyACM device so a user can easily access it
    # without being added to the uucp group. This in turn will make it so EVERY user
    # can access these devices
    SUBSYSTEM=="tty", KERNEL=="ttyACM*", ATTRS{idVendor}=="346e", ACTION=="add", MODE="0666", TAG+="uaccess"
    
    # Add uaccess tag to uinput devices to create virtual joysticks
    SUBSYSTEM=="misc", KERNEL=="uinput", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';
  environment.systemPackages = [
    (
      pkgs.boxflat
      #pkgs.boxflat.overrideAttrs (
      #  oldAttrs: {
      #    src =  pkgs.fetchFromGitHub {
      #      owner = "Lawstorant";
      #      repo = "boxflat";
      #      rev = "90cc805f324fbb3f0d75e180ae9bea99dc967c4c";
      #      hash = "sha256-6y6hGw3oLTqToumr1xtMCbyCck+5M4apu6mTSIkJDh4=";
      #    };
      #    propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [
      #      pkgs.python3Packages.dbus-python
      #      pkgs.trayer
      #    ];
      #    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [
      #      pkgs.trayer
      #    ];
      #    buildInputs = oldAttrs.buildInputs ++ [
      #      pkgs.trayer
      #    ];
      #    pythonRelaxDeps = oldAttrs.pythonRelaxDeps ++ [ "trayer" ];
      #    pythonRuntimeDepsCheck = '''';
      #  }
      #)
    )
  ];
}
