# Renice root shells, since we often use them when there are problems
if [ $UID -eq 0 ]; then
    renice -n -1 -p $$ > /dev/null
fi

# Load local files
for i in $ZSH/lib/*.zsh ; do
    source $i;
done

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

# Terraform autocompletion
if which terraform &>/dev/null; then
    complete -o nospace -C $(which terraform) terraform
fi
