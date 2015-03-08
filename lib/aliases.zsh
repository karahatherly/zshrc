# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias -- -='cd -'
alias mkcd=take
alias rm="rm -v --one-file-system"

# Super user
alias _='sudo'
alias please='sudo'

alias pip-3.3="python3.3 =pip"
alias pip-2.7="python2.7 =pip"
alias py.test="python3.3 =py.test"

# Show history
alias history='fc -l 1'

# List direcory contents
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'
alias la='ls -A'
alias sl=ls # often screw this up
alias rgrep='grep -rn --exclude-dir=.git' #grep is ~100x faster than ack for simple regexes
alias iotop='sudo iotop'
alias mtr='mtr --curses'
alias dmesg='dmesg -H'
alias x='xdg-open'

# Equo
alias eqs='equo search'
alias eqsh='equo match --verbose'
alias eqi='sudo nice equo install'
alias equ="sudo nice equo upgrade --ask"
alias equp="sudo nice equo upgrade --pretend"
alias eqc="sudo equo conf update"
alias eqr="sudo equo remove --ask --deep"
alias eqf="equo query files"
alias eqb="equo query belongs"
alias spmsync="sudo equo rescue spmsync --ask"
alias spmup='nice sudo emerge -avuN $(equo query revisions 9999 -q)'

alias emerge="nice emerge"
alias eclog="emerge -pvl --nodeps"

#Vcat and Vless (see lib/functions.zsh)
alias vc="vcat"
alias vl="vless"
alias tcat="tail -n +0"

