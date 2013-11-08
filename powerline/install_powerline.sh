#!/bin/bash

if [ $(whoami) == "root" ]; then
    echo "This script should not be run as root, as it modifies the current user's ZSH prompt. Doing so for root is a bad idea, as if it breaks you will be unable to login."
    exit
fi

#powerline itself
sudo equo install zsh dev-python/pygit2 dev-python/psutil
sudo pip install git+git://github.com/Lokaltog/powerline

#fonts
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.avail/
sudo fc-cache -vf
sudo eselect fontconfig enable 10-powerline-symbols.conf

#not enabling vim plugin cause it's broken (ironically)


#Powerline settings are part of this repo, so we need to add symlink for them
if [ ! -d ~/.config/powerline ]; then
    cd ~/.config
    ln -s ~/.oh-my-zsh/powerline/config powerline
    cd - >/dev/null
fi

