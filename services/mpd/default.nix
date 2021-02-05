{ config, pkgs, ... }:

{
  services.mpd = {
    enable = true;
    musicDirectory = /home/emmy/Music;
    extraConfig = ''
      audio_output {
        type "alsa"
        name "Alsa"
        server "127.0.0.1"
      }
    '';               
  };
  xdg.configFile."~/.mpdasrc".source = ./.mpdasrc;
}