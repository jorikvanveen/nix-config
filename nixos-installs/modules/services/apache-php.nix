{ pkgs, pkgs-php74, ... }: {
  services.httpd = {
    enable = true;
    package = pkgs-php74.apacheHttpd;
    virtualHosts = {
      localhost = {
        documentRoot = "/srv/apache/avdvegt/public_html"; 
      };
    };
    phpPackage = pkgs-php74.php74.buildEnv {
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
