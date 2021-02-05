{ config, pkgs, ... }:

{
  services.ibus = {
    enable = true;
    package = pkgs.ibus;
    script = ''
      ibus-daemon &
    '';
  };
}