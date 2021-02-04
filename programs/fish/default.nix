{ config, pkgs, lib, ... }:
let
  fenv = {
    name = "foreign-env";
    src = pkgs.fishPlugins.foreign-env.src;
  };
in
{
  programs.fish = {
    enable = true;
    plugins = [ fenv ];
  };
  xdg.configFile."fish/functions/fish_prompt.fish".source = ./fish_prompt.fish;
}