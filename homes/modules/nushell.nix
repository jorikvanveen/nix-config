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
        | split column -n 2 "="
        | rename key val
        | reduce --fold {} {|it, acc| $acc | insert $it.key $it.val }
        | load-env
      }
      
      def random-emoji [] {
        let runs = [
          [0x1F300 0x1F320] [0x1F32D 0x1F335] [0x1F337 0x1F37C] [0x1F37E 0x1F393]
          [0x1F3A0 0x1F3CA] [0x1F3CF 0x1F3D3] [0x1F3E0 0x1F3F0] [0x1F3F4 0x1F3F4]
          [0x1F3F8 0x1F42C] [0x1F42E 0x1F43E] [0x1F440 0x1F440] [0x1F442 0x1F4FC]
          [0x1F4FF 0x1F53D] [0x1F54B 0x1F54E] [0x1F644 0x1F64F] [0x1F680 0x1F6C5]
          [0x1F6CC 0x1F6CC] [0x1F6D0 0x1F6D2] [0x1F6D5 0x1F6D7]
        ]
        $runs | each {|r| seq $r.0 $r.1 } | flatten | shuffle | first
        | into binary | bytes reverse | encode hex | str trim --left --char '0'
        | char -u $in
      }

      $env.config.edit_mode = "vi"
    '';
  };
}
