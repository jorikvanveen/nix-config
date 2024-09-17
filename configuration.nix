# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, stable, inputs, zen_flake, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  specialisation = {
    gaming.configuration = {
      # Disable gnome
      services.xserver.displayManager.gdm.enable = false;
      services.xserver.desktopManager.gnome.enable = false;

      # Enable KDE plasma 6
      services.displayManager.sddm.enable = true;
      services.displayManager.sddm.wayland.enable = true;
      services.desktopManager.plasma6.enable = true;

      # Make gaming configuration an entry in the boot menu
      system.nixos.tags = [ "gaming" ];

      # Enable proprietary nvidia drivers
      services.xserver.videoDrivers = [ "nvidia" ];

      # https://wiki.nixos.org/wiki/Nvidia
      hardware.nvidia = {
        # Required
        modesetting.enable = true;

        # Fixes issues with sleep/suspend.
        powerManagement.enable = false;

        # Turns off the gpu when not in use.
        # powerManagement.finegrained = true;

        # Uses the open kernel modules
        open = true;

        # Enable nvidia-settings GUI
        nvidiaSettings = true;

        # .production is nvidia-550 at the time of writing
        package = config.boot.kernelPackages.nvidiaPackages.beta;

        prime = {
          nvidiaBusId = "PCI:1:0:0";
          intelBusId = "PCI:0:2:0";
          #offload = {
          #  enable = true;
          #  enableOffloadCmd = true;
          #};
	  sync.enable = true;
        };
      };
    };
  };

  hardware.graphics.enable = true;

  hardware.bluetooth.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = lib.mkDefault true;
  services.xserver.desktopManager.gnome.enable = lib.mkDefault true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.main = {
    isNormalUser = true;
    description = "Jorik";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    shell = pkgs.nushell;
    useDefaultShell = true;
    packages = with pkgs; [
      thunderbird
    ];
  };

  programs.nix-ld.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode.enable = true;
  programs.gamemode.enableRenice = true;
  programs.gamemode.settings = {
    general = {
      renice = 10;
    };
  };
  # Install firefox.
  programs.firefox.enable = true;
  programs.firefox.package = pkgs.firefox;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    pkgs.gnome-tweaks
    pkgs.gnomeExtensions.forge
    pkgs.gnomeExtensions.cronomix
    pkgs.zed-editor
    pkgs.dconf-editor
    pkgs.alacritty
    pkgs.open-webui
    pkgs.nixd
    pkgs.steam-run
    pkgs.galaxy-buds-client
    pkgs.skia
    pkgs.adwaita-icon-theme
    pkgs.kdePackages.breeze
    pkgs.brave
    pkgs.blueman
    pkgs.calibre
    pkgs.errands
    pkgs.gnome-pomodoro
    pkgs.protonup-qt

    # Cli utilities
    pkgs.ripgrep
    pkgs.jq
    pkgs.tmux
    pkgs.file
    pkgs.neovim
    pkgs.git

    # Vulkan stuff
    pkgs.vulkan-loader
    pkgs.mesa
    pkgs.vulkan-headers
    pkgs.vulkan-tools

    pkgs.rustup

    pkgs.nicotine-plus
    pkgs.g4music

    zen_flake.default

    pkgs.qgis-ltr
    pkgs.qbittorrent

    pkgs.obsidian
  ];

  fonts.packages = with pkgs; [
    fira-code
    inputs.apple-fonts.packages.x86_64-linux.sf-mono-nerd
    inputs.apple-fonts.packages.x86_64-linux.sf-pro
    inputs.apple-fonts.packages.x86_64-linux.ny
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [  "New York Medium" ];
      sansSerif = [ "SF Pro" ];
      monospace = [ "SFMono Nerd Font" ];
    };
  };

  services.syncthing = {
    enable = true;
    user = "main";
    dataDir = "/home/main/Documents";
    configDir = "/home/main/.config/syncthing";
  };

  services.open-webui = {
    enable = true;
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 5173 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
