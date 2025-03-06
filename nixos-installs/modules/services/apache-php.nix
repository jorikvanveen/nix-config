{ pkgs, pkgs-php74, ... }: let
  pkgs = pkgs-php74;
  php = pkgs.php74;
in {
  imports = [
    ./msmtp.nix
  ];

  services.httpd = {
    enable = true;
    package = pkgs.apacheHttpd;
    virtualHosts = {
      localhost = {
        documentRoot = "/srv/apache/avdvegt/public_html"; 
      };
    };
    phpPackage = php.buildEnv {
      extensions = ({ enabled, all }: enabled ++ (with all; [
          xdebug
      ]));
      extraConfig = ''
          xdebug.mode=debug
      '';
    };
    enablePHP = true;
  };
}
