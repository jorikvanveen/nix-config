{
  programs.nushell = {
    enable = true;
    # configFile.source = ../program-config/nushell/config.nu;
    shellAliases = {
      gs = "git status";
      gaa = "git add --all";
      gc = "git commit -m";
      gb = "git branch";
      gp = "git push";
      gpl = "git pull";

      vi = "nvim";
      vim = "nvim";
      #cd = "z";
      t = "tmux";
      ta = "tmux a";
    };
    extraConfig = ''
      alias core-ls = ls

      def --wrapped ls [...rest] {
        lsd ...$rest --json --icon always --icon-theme fancy --color always --hyperlink always
        | from json
        | get 0.content
        | select type display size date
        | update date {|row| $row.date | into datetime}
        | update size {|row| $row.size | into filesize}
      }

      def --wrapped lsdata [...rest] {
        lsd ...$rest --json --icon always --color never
        | from json
        | get 0.content
        | update date {|row| $row.date | into datetime}
        | update size {|row| $row.size | into filesize}
      }

      def dui [path: glob] {
        ^du --exclude-from=/home/main/shared/personal/.stignore -s $path
        | str replace -a "\t" "  "
        | from ssv  -n
        | rename size path
        | into value
        | update size { |row| $row.size | into filesize }
        | sort-by -r size
      }

      def --env source-dotenv [] {
        open .env
        | lines
        | where $it != ""
        | split column "="
        | rename key val
        | reduce --fold {} {|it, acc| $acc | insert $it.key $it.val }
        | load-env
      }
      $env.config.edit_mode = "vi"
    '';
  };
}
