#!/usr/bin/env zsh

if [ ! -d "$ZSH_CUSTOM/themes/" ]; then
    mkdir -p $ZSH_CUSTOM/themes/
fi

cp ./other/zsh-theme/hyperzsh.zsh-theme $ZSH_CUSTOM/themes/

if [ -z "$XDG_CONFIG_HOME" ]; then
    mkdir -p ~/.config 2> /dev/null
    cp -R ./other/nvim ~/.config/nvim
else
    mkdir -p $XDG_CONFIG_HOME 2> /dev/null
    cp -R ./other/nvim $XDG_CONFIG_HOME/nvim
fi
