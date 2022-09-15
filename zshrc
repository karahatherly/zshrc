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
else
    new-agent
fi

if [ -d $HOME/sources/nvm ]; then
    source $HOME/sources/nvm/nvm.sh
fi

# Terraform autocompletion
# autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

