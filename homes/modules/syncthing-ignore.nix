{ homedir, ... }: {
  home.file.personal-stignore = {
    target = homedir + "/shared/personal/.stignore";
    text = ''
      (?d)**/target
      (?d)**/node_modules
      (?d)**/site-packages
      **/*.laz
      **/*.direnv
      **/*.osm.pbf
      (?d)**/build
      **/*.map
      **/*.mbtiles
    '';
  };
}
