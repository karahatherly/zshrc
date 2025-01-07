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
    # TODO: add a built-in to Powerline-hs to find this - we were using pip before but it's too slow
    POWERLINE_PATH="/usr/local/share/zsh/site-functions/powerline.zsh"

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
# Make sure there's an agent, if we don't already have one
if [ -n "${SSH_AUTH_SOCK:-}" ]; then
    true
elif [ -f /tmp/.ssh-agent ]; then
    source /tmp/.ssh-agent
    # If the agent isn't running anymore, need to restart it
    ssh-add -l &>/dev/null || new-agent
else
    new-agent
fi



emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'

