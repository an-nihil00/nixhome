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