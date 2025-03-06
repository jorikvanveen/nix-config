{ pkgs, ... }: {
  services.httpd = {
    enable = true;
    virtualHosts = {
      localhost = {
        documentRoot = "/srv/apache/avdvegt/public_html"; 
      };
    };
    phpPackage = pkgs.php.buildEnv {
      extensions = ({ enabled, all }: enabled ++ (with all; [
          xdebug
      ]));
      extraConfig = ''
          xdebug.mode=debug
      '';
    };
  };
}
