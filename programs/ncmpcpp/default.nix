{ config, pkgs, ... }:

{
  programs.ncmpcpp = {
    enable = true;
    settings = {
      song_list_format = "$6{%a - }{%t}|{$8%f$9}$R{$4%l$9}";
    };
  };
}