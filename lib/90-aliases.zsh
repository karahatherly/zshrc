# Basic directory operations
alias ..='cd ..'
alias ...='cd ../..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'

alias rm="rm -v --one-file-system"
alias rmq='\rm -rf --one-file-system'
alias cp="cp --reflink=auto"

# Cat aliases
# TODO: replace this with something fast enough to replace cat
alias vc="$ZSH/bin/vimcat.sh"
alias c=cat
alias tcat="tail -n +0"

# List direcory contents
alias sl=ls
alias ll='ls -lh'
alias la='ls -A'

# Misc commands
alias x='xdg-open'
alias lsblk='lsblk -o NAME,MAJ:MIN,SIZE,RO,TYPE,FSTYPE,UUID,MOUNTPOINT'
alias rgrep='grep -rn --exclude-dir=.git'
alias ag=rg
alias agQ='rg -F'
alias iotop='sudo iotop -o'
alias mtr='mtr --curses'
alias dmesg='dmesg -H'
alias dot-update='for i in ~/.vim ~/.zsh ~/.config/i3 ; do test -d $i && git -C $i pull && git -C $i submodule update; done'
alias parallel='parallel --citation'
alias ip='ip -c'
alias shutup_and_take_my_memory='prlimit -vunlimited'

# Stack aliases
alias sb='nice stack build'
alias sbt='nice stack test --no-run-tests'
alias st='nice stack test'
alias hoogle='nice ionice -c3 stack hoogle -- server --local -p 60080'

# Equo & Portage
alias eqs='equo search'
alias eqsh='equo match --verbose'
alias equ="sudo nice equo upgrade --ask"
alias equp="sudo nice equo upgrade --pretend"
alias equk="sudo kernel-switcher switch linux-sabayon"
alias eqc="sudo dispatch-conf"
alias eqr="sudo equo remove --ask --deep"
alias eqf="equo query files"
alias eqb="equo query belongs"
alias spmsync="sudo equo rescue spmsync --ask"
alias spmup='nice sudo emerge -avuNt $(equo query revisions 9999 -q)'
alias mpv='mpv --no-audio-display'

function eqi() {
    sudo nice equo install $@
    rehash
}

alias emerge="nice emerge"

# Vim aliases
alias v="nvim"
alias qv="nvim-qt"
alias qvdiff="nvim-qt $@ -- -d"

# Git aliases
alias t=tig
alias dm=dispatch-merge
alias gfzf='git ls-files | fzf'

alias g='git'
alias gs='git status'
alias gp='git push'
alias gpu='git push -u'
alias gr='git remote'
alias gf='git fetch'
alias gft='git fetch --tags'
alias gpl='git pull'
alias gplm='git checkout master && git pull && git checkout -'
alias ga='git add'
alias gap='git add -p'
alias gsh='git show'
alias gcl='git clone --recursive'
alias groot='cd $(git rev-parse --show-toplevel || echo ".")'
alias gw='git worktree'

alias gbi='git bisect'
alias gbb='git bisect bad'
alias gbg='git bisect good'

alias gb='git branch'
alias gba='git branch -a'

alias gco='git checkout'
alias gcom='git checkout master'
alias gcop='git checkout -p'

alias gc='git commit -v'
alias gcp='git commit -pv'
alias gcq='git commit'
alias gc!='env GIT_EDITOR=/bin/true git commit'
alias gcA='git commit --amend -v'
alias gcA!='git commit --amend -C HEAD'
alias gca='git commit -v -a'
alias gcaA='git commit -a --amend -v'
alias gcaA!='git commit -a --amend -C HEAD'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcf='git commit --fixup'

alias gd='git diff'
alias gdc='git diff --cached'
alias gdm='git diff master'
alias gdr='git diff root'
alias gdn='git diff --no-index --color=always'
alias gdnw='git diff --no-index --color-words'
alias gdw='git diff --color-words'
alias gdx='git diff --color-words=.'

alias gl='git log'
alias glp='git log -p'
alias git-graph='git log --graph --oneline --decorate'
alias gl-authors="git log --pretty=format:'%h %<(20)%an %<(40)%ae %s'"

alias gm='git merge'
alias gma='git merge --abort'
alias gmt='git mergetool --no-prompt'
alias gmm='env GIT_EDITOR=/bin/true git merge master'

alias grb='git rebase'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias grbs='git rebase --skip'
alias grb-show-current='git show $(cat "$(g rev-parse --git-dir)/rebase-apply/original-commit")'

alias grs='git reset --soft'
alias grm='git reset --mixed'
alias grh='git reset --hard'

alias gs='git status'
alias gss='git status -s'

