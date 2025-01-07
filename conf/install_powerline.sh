#!/bin/bash

sudo equo install zsh dev-python/pygit2 dev-python/psutil
sudo eselect fontconfig enable 10-powerline-symbols.conf

# change console font to one with better unicode support
sudo sed 's/^FONT.*/FONT=eurlatgr/' /etc/vconsole.conf

