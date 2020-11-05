#!/bin/bash
set -e

ZSH="$(dirname "$(realpath "$0")")"
pushd "$ZSH" >/dev/null

# Make sure SSH uses TOFU (so that git clone is non-interactive)
if [ ! -f ~/.ssh/config ]; then
    mkdir -p ~/.ssh
    cat <<EOF > ~/.ssh/config
# TOFU
Host *
    StrictHostKeyChecking accept-new
EOF
fi

# XDG config directories
[ -d ~/.config ] || git clone git@github.com:rdnetto/xdg-config.git ~/.config

# RC files
cd "$HOME"
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

