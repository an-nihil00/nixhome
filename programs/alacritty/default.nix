{ fontSize, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = "#000000";
          foreground = "#ffffff";
        };
        normal = {
          black = "#000000";
          red = "#ff5555";
          green = "#55ff55";
          yellow =  "#9d5f8d"; #don't really like yellow so we're using purple instead
          blue = "#5555ff";
          magenta = "#e60073";
          cyan = "#55ffff";
          white = "#ffffff";
        };
        bright = {
          black = "#555555";
          red = "#ff5555";
          green = "#55ff55";
          yellow =  "#9d5f8d";
          blue = "#5555ff";
          magenta = "#e60073";
          cyan = "#55ffff";
          white = "#ffffff";
        };
      };
      font = {
        normal = {
          family = "Terminus";
        };
        size = 7.0;
      };
      shell.program = "${pkgs.fish}/bin/fish";
      selection.save_to_clipboard = true;
    };
  };
}