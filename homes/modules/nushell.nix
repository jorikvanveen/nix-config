{
  programs.nushell = {
    enable = true;
    # configFile.source = ../program-config/nushell/config.nu;
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
      $env.config.edit_mode = "vi"
    '';
  };
}
