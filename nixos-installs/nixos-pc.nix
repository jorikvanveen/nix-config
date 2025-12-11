
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, ... }:
{
  imports =
    [
      ./hardware/nixos-pc-hardware.nix

      ./generic-cli.nix
      ./generic-desktop.nix

      ./modules/main-user.nix
      ./modules/syncthing-pc.nix
      ./modules/sshfs.nix
      ./modules/sops.nix
      ./modules/services/sunshine.nix
      ./modules/auto-login.nix
      ./modules/ddcutil.nix
      ./modules/services/ssh.nix
      ./modules/reaper.nix
      ./modules/vinegar.nix
      ./modules/input-remapper.nix
      ./modules/xmrig.nix
    ];

  boot.kernel.sysctl."fs.file-max" = 1000000;
  boot.kernelPackages = inputs.nixpkgs-stable.legacyPackages.x86_64-linux.linuxPackages_6_17;

  networking.hostName = "nixos-pc"; # Define your hostname.
  networking.firewall.enable = true;
  networking.interfaces.enp34s0.wakeOnLan.enable = true;

  musnix.enable = true;

  environment.systemPackages = [
    inputs.zen_flake.packages.x86_64-linux.default
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
