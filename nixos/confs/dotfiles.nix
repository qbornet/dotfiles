{ config, pkgs, dotfiles, ... }:

{
  home.file = {
    # Ghostty configuration file
    ".config/ghostty/config".source = "${dotfiles}/config/ghostty/config";
    ".config/nvim" = {
      source = "${dotfiles}/config/nvim";
      recursive = true;
    };
  };
}
