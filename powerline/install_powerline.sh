#!/bin/bash

if [ $(whoami) == "root" ]; then
    echo "This script should not be run as root, as it modifies the current user's ZSH prompt. Doing so for root is a bad idea, as if it breaks you will be unable to login."
    exit
fi

#fonts
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.avail/
sudo fc-cache -vf

if [ -x /usr/bin/equo ]; then
    sudo equo install zsh dev-python/pygit2 dev-python/psutil
    sudo eselect fontconfig enable 10-powerline-symbols.conf
elif [ -x /usr/bin/apt-get ]; then
    sudo apt-get install zsh pygit2 psutil python-pip python2.7-dev python-psutil autojump
    sudo pip install pip --upgrade
    sudo pip install pygit2
    cd /etc/fonts/conf.d
    sudo ln -s /etc/fonts.avail/10-powerline
else
    echo "Could not find package manager"
fi

#powerline itself
sudo pip install git+git://github.com/Lokaltog/powerline

#change console font to one with better unicode support
sudo sed 's/^FONT.*/FONT=eurlatgr/' /etc/vconsole.conf

#Powerline settings are part of this repo, so we need to add symlink for them
if [ ! -d ~/.config/powerline ]; then
    cd ~/.config
    ln -s ~/.oh-my-zsh/powerline/config powerline
    cd - >/dev/null
fi

