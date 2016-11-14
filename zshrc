# Renice root shells, since we often use them when there are problems
if [ $UID -eq 0 ]; then
    renice -n -1 -p $$ > /dev/null
fi

# Load local files
for i in $ZSH/lib/*.zsh ; do
    source $i;
done


# TODO WIP: load plugins
source <(antibody init)

# TODO: add fasd (instead of autojump)
# TODO: parse https://github.com/unixorn/awesome-zsh-plugins#plugins
antibody bundle <<EOF
    zsh-users/zsh-completions
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-history-substring-search
EOF


# Load powerline
# TODO: move this into a plugin
# --------------------------------------------------------------------------------
TTY="$(tty | awk -F/ '{print $3;}')"
# TODO: add a built-in to Powerline-hs to find this - we were using pip before but it's too slow
POWERLINE_PATH="/usr/share/zsh/site-contrib/powerline.zsh"

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
# --------------------------------------------------------------------------------

