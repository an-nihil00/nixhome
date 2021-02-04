{ config, pkgs, ... }:
let
  mypolybar = pkgs.polybar.override {
    alsaSupport   = true;
    pulseSupport  = true;
  };

  bars   = builtins.readFile ./bars.ini;
  colors = builtins.readFile ./colors.ini;

  mprisScript = pkgs.callPackage ./scripts/mpris.nix {};

  mpris  =  ''
            [module/mpris]
            type = custom/script
            exec = ${mprisScript}/bin/mpris
            tail = true
            label-maxlen = 60
            interval = 2
            format = <label>
           '';
  xmonad = ''
            [module/xmonad]
            type = custom/script
            exec = ${pkgs.xmonad-log}/bin/xmonad-log
            tail = true
           '';
in
{
  services.polybar = {
    enable = true;
    package = mypolybar;
    config = ./config.ini;
    extraConfig = colors + bars + mpris + xmonad;
    script = ''
      polybar main &
    '';
  };
}