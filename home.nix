{ pkgs, inputs, lib, config, options, specialArgs, modulesPath, nixosConfig, osConfig }: {
  programs.home-manager.enable = true;

  home = let home = "/home/main"; in {
    username = "main";
    homeDirectory = home;
    stateVersion = "24.05";

    file.zed = {
      enable = true;
      source = program-config/zed;
      target = home + "/.config/zed";
      recursive = true;
    };


  };

  # NodeJS workaround for Zed https://github.com/zed-industries/zed/issues/12631
  xdg.dataFile = let
    nodeVersion = "node-v22.5.1-linux-x64";
    nodePackage = pkgs.nodejs_22;
  in {
    # Adding different directories one by one, as Zed wants to write to the "./cache" dir
    "zed/node/${nodeVersion}/bin".source = "${nodePackage}/bin";
    "zed/node/${nodeVersion}/include".source = "${nodePackage}/include";
    "zed/node/${nodeVersion}/lib".source = "${nodePackage}/lib";
    "zed/node/${nodeVersion}/share".source = "${nodePackage}/share";
  };

  xdg.mimeApps = {
		enable = true;
		defaultApplications = {
			"video/mp4" = "vlc.desktop";
			"text/calendar" = "gnome-calendar.desktop";
		};
	};

  programs.git = import program-config/git.nix;

  programs.carapace.enable = true;
  programs.carapace.enableBashIntegration = false;
  programs.carapace.enableNushellIntegration = true;
  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    settings = {
      add_newline = true;
      # character = {

      # };
    };
  };

  programs.nushell = {
    enable = true;
    # configFile.source = program-config/nushell/config.nu;
    extraConfig = ''
      alias core-ls = ls
      def ls [...args] { lsd ...$args --json --icon always --icon-theme fancy --color always | from json | get 0.content | select display type content date | update date {|row| $row.date | into datetime} }
      def lsdata [...args] { lsd ...$args --json --icon always --icon-theme fancy --color always | from json }
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableNushellIntegration = true;
  };

  programs.eza = {
    enable = true;
  };

  #programs.lsd = {
  #  enable = true;
  #
  #};

  programs.bash.enable = true;


  dconf.settings = import ./dconf.nix { inherit lib; };
}
