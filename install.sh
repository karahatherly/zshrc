#!/bin/bash
set -e

ZSH="$(dirname "$(realpath "$0")")"
pushd "$ZSH" >/dev/null

# XDG config directories
mkdir -p ~/.config
cd ~/.config
[ -d ~/.config/powerline ] || ln -sf "$ZSH/conf/powerline" .
[ -d ~/.config/git ] || ln -sf "$ZSH/conf/git" .
[ -d ~/.config/nvim ] || ln -sf ~/.vim .

# RC files
cd "$HOME"
ln -sf "$ZSH/conf/tmux.conf" .tmux.conf
ln -sf "$ZSH/conf/tigrc" .tigrc
ln -sf "$ZSH/zshenv" .zshenv
ln -sf "$ZSH/zshenv" .zprofile
ln -sf "$ZSH/zshenv" .profile
ln -sf "$ZSH/zshrc" .zshrc

popd >/dev/null

# Colour scheme for Konsole
if ! [ -d ~/.local/share/konsole/Dracula.colorscheme ] ; then
    mkdir -p ~/.local/share/konsole
    pushd ~/.local/share/konsole
    curl "https://raw.githubusercontent.com/dracula/konsole/master/Dracula.colorscheme" > Dracula.colorscheme

    [ -f Shell.profile ] && sed -i 's/ColorScheme.*/ColorScheme=Dracula/' Shell.profile

    popd >/dev/null
fi

sudo layman -o 'https://ebuilds.janchren.eu/repos/rindeal/repositories.xml' -f -a rindeal
sudo emerge -avt diff-so-fancy

