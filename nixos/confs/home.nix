{ config, pkgs, dotfiles, ... }:

{
  imports = [
    ./dotfiles.nix
  ];

  home.username = "qbornet";
  home.homeDirectory = "/home/qbornet";
  home.stateVersion = "25.05";


  programs.home-manager.enable = true;
}
