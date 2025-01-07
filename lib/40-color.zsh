## Aliases to enable color

# grep
export GREP_COLOR='mt=1;32'
alias grep='grep --color=auto'

# ls
export QUOTING_STYLE=literal
autoload -U colors && colors
alias ls='ls --color=auto'

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

