# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, spicetify-nix, lib, inputs, zen_flake, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./nixos-tp-p15v-hardware.nix

      # Machine-independent stuff
      ./generic.nix

      # Machine-specific syncthing config
      ./modules/syncthing-laptop.nix

      # Add boot entry that enables NVIDIA dGPU
      ./modules/gaming-specialisation.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-laptop"; # Define your hostname.

  hardware.bluetooth.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.main = {
    isNormalUser = true;
    description = "Jorik";
    extraGroups = [ "networkmanager" "wheel" "gamemode" "kvm" "docker" ];
    shell = pkgs.nushell;
    useDefaultShell = true;
  };

  documentation.dev.enable = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };

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
