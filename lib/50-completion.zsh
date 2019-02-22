autoload -U compinit
compinit

# Move cursor to end of word following completion
setopt always_to_end

# Immediately select the first option when showing the completion menu.
setopt menu_complete

# The specified characters introduce word boundaries
WORDCHARS=${WORDCHARS//[\/.;-]}

# Enable case and hyphen insensitivity
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

# Enable selection of option with arrow keys, and specify formatting for certain commands
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# use /etc/hosts and known_hosts for hostname completion
[ -r /etc/ssh/ssh_known_hosts ] && _global_ssh_hosts=(${${${${(f)"$(</etc/ssh/ssh_known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _global_ssh_hosts=()
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r ~/.ssh/config ] && _ssh_config=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p')) || _ssh_config=()
[ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=(
  "$_ssh_config[@]"
  "$_global_ssh_hosts[@]"
  "$_ssh_hosts[@]"
  "$_etc_hosts[@]"
  "$HOST"
  localhost
)
zstyle ':completion:*:hosts' hosts $hosts
zstyle ':completion:*' users off

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH/cache/

# Show dots while performing completion
expand-or-complete-with-dots() {
    # toggle line-wrapping off and back on again
    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti rmam
    print -Pn "%{%F{red}......%f%}"
    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti smam

    zle expand-or-complete
    zle redisplay
}

zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# Completions for Haskell Stack
# TODO: move to plugin
autoload -U +X bashcompinit && bashcompinit
cmd_exists stack && eval "$(stack --bash-completion-script stack)"

