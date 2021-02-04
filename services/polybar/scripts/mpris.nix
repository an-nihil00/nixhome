{ pkgs, ...}:

let
  pctl = "${pkgs.playerctl}/bin/playerctl";
in
  pkgs.writeShellScriptBin "mpris" ''
    echo $(${pctl} --player=rhythmbox,%any metadata --format '{{ artist }} - {{ title }}')
  ''