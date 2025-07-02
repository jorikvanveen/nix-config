{
  services.calibre-web = {
    listen.port = 8898; 
    enable = true;
    user = "main";
    options.calibreLibrary = "/home/main/data/personal/Books/";
  };
}
