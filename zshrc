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
