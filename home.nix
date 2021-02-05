{ config, pkgs, ... }:

let
  defaultPkgs = with pkgs; [
    any-nix-shell
    discord
    firefox
    gimp
    git
    gnome3.gnome-keyring
    gnupg
    hugo
    inkscape
    jetbrains.idea-community
    keepassxc
    lxappearance
    maven
    mpdas
    neofetch
    ncmpcpp
    nicotine-plus
    playerctl
    pinentry
    protonvpn-cli
    protonvpn-gui
    rhythmbox
    scrot
    signal-desktop
    sweet
    unzip
    usbutils
    vlc
    wget
    wine
    xclip
  ];

  gnomePkgs = with pkgs.gnome3; [
    adwaita-icon-theme
  ];
  
  polybarPkgs = with pkgs; [
    font-awesome-ttf
  ];
    
in
{
  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = p: {
      # temporary hack for fish until there's a fix upstream
      fish-foreign-env = pkgs.fishPlugins.foreign-env;
    };
  };
  
  home = {
    username = "emmy";
    homeDirectory = "/home/emmy";

    packages = defaultPkgs ++ polybarPkgs ++ gnomePkgs;
    stateVersion = "21.03";
  };

  imports = [
    ./programs/emacs/default.nix
    ./programs/fish/default.nix
    ./programs/ncmpcpp/default.nix
    ./programs/rofi/default.nix
    ./programs/xmonad/default.nix
    ./programs/alacritty/default.nix

    ./services/polybar/default.nix
    ./services/mpd/default.nix
  ];
}
