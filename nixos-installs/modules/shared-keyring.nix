{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  # KWallet ships activation for its KDE API, but not this libsecret bus name.
  secretService = pkgs.writeTextDir "share/dbus-1/services/org.freedesktop.secrets.service" ''
    [D-BUS Service]
    Name=org.freedesktop.secrets
    Exec=${pkgs.kdePackages.kwallet}/bin/ksecretd
  '';
in
{
  services.gnome.gnome-keyring.enable = lib.mkForce false;

  security.pam.services = {
    login = {
      enableGnomeKeyring = lib.mkForce false;
      kwallet = {
        enable = true;
        forceRun = true;
      };
    };
    kde = {
      enableGnomeKeyring = lib.mkForce false;
      kwallet.enable = true;
    };
    sddm.enableGnomeKeyring = lib.mkForce false;
    sddm-autologin.enableGnomeKeyring = lib.mkForce false;
  };

  services.dbus.packages = [
    pkgs.kdePackages.kwallet
    secretService
  ];
  systemd.packages = [ pkgs.kdePackages.kwallet-pam ];
  systemd.user.services.plasma-kwallet-pam = {
    wantedBy = [ "graphical-session.target" ];
    enableDefaultPath = false;
  };

  home-manager.users.main = { lib, ... }: {
    # KWallet must be able to update aliases and migration state in this file.
    home.activation.sharedKeyring = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file kwalletrc --group Wallet --key Enabled --type bool true
      run ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file kwalletrc --group Wallet --key "Default Wallet" kdewallet
      run ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file kwalletrc --group Wallet --key "Use One Wallet" --type bool true
      run ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file kwalletrc --group KSecretD --key Enabled --type bool true
      run ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file kwalletrc --group Migration --key MigrateTo3rdParty --type bool false
      run ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file kwalletrc --group org.freedesktop.secrets --key apiEnabled --type bool true
    '';
  };

  xdg.portal = {
    extraPortals = [ pkgs.kdePackages.kwallet ];
    config.niri."org.freedesktop.impl.portal.Secret" = lib.mkForce [ "kwallet" ];
    config.kde = {
      default = [
        "kde"
        "gtk"
      ];
      "org.freedesktop.impl.portal.Secret" = [ "kwallet" ];
    };
  };

  # The shared KDE module forces Seahorse; keep this PC on KWallet instead.
  programs.ssh.askPassword = lib.mkOverride 40 "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
  environment.systemPackages = with pkgs.kdePackages; [
    kwallet
    kwallet-pam
    kwalletmanager
    ksshaskpass
  ];

  # Chromium and Electron must select the same backend in both sessions.
  nixpkgs.overlays = [
    (
      final: prev:
      let
        withSharedKeyring =
          package:
          final.symlinkJoin {
            name = "${package.name}-kwallet";
            paths = [ package ];
            nativeBuildInputs = [ final.makeWrapper ];
            postBuild = ''
              rm "$out/bin/${package.meta.mainProgram}"
              makeWrapper "${lib.getExe package}" "$out/bin/${package.meta.mainProgram}" \
                --add-flags "--password-store=kwallet6"

              # Desktop entries can bypass PATH by using the original store path.
              if [ -L "$out/share" ]; then
                rm "$out/share"
                mkdir "$out/share"
                ln -s ${package}/share/* "$out/share/"
              fi
              rm -rf "$out/share/applications"
              mkdir -p "$out/share/applications"
              cp -L ${package}/share/applications/*.desktop "$out/share/applications/"
              substituteInPlace "$out"/share/applications/*.desktop \
                --replace-quiet "${package}/bin/" "$out/bin/"
            '';
            passthru = package.passthru or { };
            meta = package.meta;
          };
      in
      {
        helium = withSharedKeyring inputs.helium-flake.packages.x86_64-linux.helium;
        ungoogled-chromium = withSharedKeyring prev.ungoogled-chromium;
        signal-desktop = withSharedKeyring prev.signal-desktop;
        vscode = withSharedKeyring prev.vscode;
        obsidian = withSharedKeyring prev.obsidian;
        feishin = withSharedKeyring prev.feishin;
      }
    )
  ];
}
