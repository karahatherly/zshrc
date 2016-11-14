# Open command line in $EDITOR usig ^X ^E
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

