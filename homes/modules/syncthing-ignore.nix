{ homedir, ... }: {
  home.file.personal-stignore = {
    target = homedir + "/shared/personal/.stignore";
    text = ''
      **/target
      **/node_modules
      **/site-packages
      **/*.laz
    '';
  };
}
