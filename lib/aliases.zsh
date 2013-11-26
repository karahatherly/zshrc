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
alias equ="sudo equo upgrade --ask"
alias eqsh='equo match --verbose'
alias spmsync="sudo equo rescue spmsync --ask"
