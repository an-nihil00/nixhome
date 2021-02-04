{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.elixir-mode
      epkgs.markdown-mode
      epkgs.fish-mode
    ];
  };
}