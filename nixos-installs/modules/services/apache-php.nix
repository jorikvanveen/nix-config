{ pkgs, ... }: {
  services.httpd = {
    enable = true;
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
