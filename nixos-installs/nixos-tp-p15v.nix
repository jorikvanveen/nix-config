# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, spicetify-nix, lib, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware/nixos-tp-p15v-hardware.nix

      # Machine-independent stuff
      ./generic.nix

      # Machine-specific syncthing config
      ./modules/syncthing-laptop.nix

      ./modules/sshfs.nix

      # Add boot entry that enables NVIDIA dGPU
      ./modules/gaming-specialisation.nix

      ./modules/eth-conn-sharing.nix

      ./modules/xanmod-kernel.nix

      ./modules/reaper.nix

      ./modules/upower.nix
    ];


  #services.kubo.settings.Addresses.Gateway = lib.mkForce "/ip4/127.0.0.1/tcp/8080";
  networking.hostName = "nixos-laptop"; # Define your hostname.

  musnix.enable = true;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  environment.systemPackages = [
    inputs.zen_flake.packages.x86_64-linux.default
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  programs.kdeconnect.enable = true;
}
