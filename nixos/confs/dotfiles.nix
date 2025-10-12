{ config, pkgs, dotfiles, ... }:

{
  home.file = {
    # Ghostty configuration file
    ".config/ghostty/config".source = "${dotfiles}/config/ghostty/config";

    # Neovim configuration file
    ".config/nvim" = {
      source = "${dotfiles}/config/nvim";
      recursive = true;
    };

    # Niri configuration
    ".config/niri/config.kdl".source = "${dotfiles}/config/niri/config.kdl";

    # Mako configuration
    ".config/mako/config".source = "${dotfiles}/mako/config";

    # Waybar configuration
    ".config/waybar" = {
      source = "${dotfiles}/config/waybar";
      recursive = true;
    };
  };
}
