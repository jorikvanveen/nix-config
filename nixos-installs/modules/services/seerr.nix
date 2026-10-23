{ inputs, pkgs, ... }:
{
  services.seerr = {
    enable = true;
    # Use master Node.js for this public service without changing global packages.
    package = pkgs.seerr.override {
      nodejs-slim_22 = inputs.nixpkgs-master.legacyPackages.${pkgs.stdenv.hostPlatform.system}.nodejs-slim_22;
    };
    port = 47333;
  };
}
