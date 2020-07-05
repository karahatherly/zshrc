# Renice root shells, since we often use them when there are problems
if [ $UID -eq 0 ]; then
    renice -n -1 -p $$ > /dev/null
fi

# Load local files
for i in $ZSH/lib/*.zsh ; do
    source $i;
done


if (cmd_exists antibody); then
    source <(antibody init)

    antibody bundle <<EOF
        zsh-users/zsh-completions
        zsh-users/zsh-autosuggestions
        zsh-users/zsh-syntax-highlighting
        zsh-users/zsh-history-substring-search
        MichaelAquilina/zsh-you-should-use
EOF
else
    echo "Antibody not installed" >&2
fi

# Load powerline
# TODO: move this into a plugin
# --------------------------------------------------------------------------------
if cmd_exists powerline-hs; then
    TTY="$(tty | awk -F/ '{print $3;}')"

    # Path in: raiagent overlay, Debian, Gentoo
    PYTHON_VER="$(python3 --version | grep -o '3..')"
    for POWERLINE_PATH in "/usr/share/zsh/site-contrib/powerline.zsh" "/usr/share/powerline/bindings/zsh/powerline.zsh" "/usr/lib/python${PYTHON_VER}/site-packages/powerline/bindings/zsh/powerline.zsh" ; do
        [[ -r "$POWERLINE_PATH" ]] && break
    done

    [ -f /etc/vconsole.conf ] && source /etc/vconsole.conf

    if [[ ! -r $POWERLINE_PATH ]] ; then
        echo "Powerline is not installed."
        POWERLINE_PATH="/dev/null"
    elif [ "$TTY" != "pts" -a "$FONT" != "eurlatgr" ]; then
        # We need a console font that supports unicode
        echo "Running on $(tty) with unsupported font. Please edit /etc/vconsole.conf to use eurlatgr."
        setfont eurlatgr
    fi

    POWERLINE_COMMAND=powerline-hs
    POWERLINE_CONFIG_COMMAND=/bin/true
    source $POWERLINE_PATH

    unset FONT KEYMAP POWERLINE_PATH TTY
else
    echo "Powerline-hs not installed" >&2
fi
# --------------------------------------------------------------------------------

# Load work key
if [ -f /media/Work/ssh-key/load.sh ]; then
    source /media/Work/ssh-key/load.sh
    alias ssh='ssh -F /media/Work/ssh-key/config'
fi

# If we have an agent, load it
[ -f /tmp/.ssh-agent ] && source /tmp/.ssh-agent

if [ -d $HOME/sources/nvm ]; then
    source $HOME/sources/nvm/nvm.sh
fi
