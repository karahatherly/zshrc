# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias -- -='cd -'

# Super user
alias _='sudo'
alias please='sudo'

#alias g='grep -in'
alias pip-3.3="python3.3 =pip"
alias py.test="python3.3 =py.test"

# Show history
alias history='fc -l 1'

# List direcory contents
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'
alias la='ls -A'
alias sl=ls # often screw this up

alias afind='ack-grep -il'
alias iotop='sudo iotop'

# Equo
alias eqs='equo search'
alias eqsh='equo match --verbose'
alias eqi='sudo equo install'
alias equ="sudo equo upgrade --ask"
alias spmsync="sudo equo rescue spmsync --ask"
alias eqc="sudo equo conf update"
