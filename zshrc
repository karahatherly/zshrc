# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#NOTE: This is a fallback, since powerline overrides it
ZSH_THEME="gentoo"
#other suggestions: candy, crunch, gianu, jreese, lukerandall, nebirhos, superjarin, bira, josh

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Renice root shells, since we often use them when there are problems
if [ $UID -eq 0 ]; then
    renice -n -1 -p $$ > /dev/null
fi

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git git-extras git-flow autojump cp last-working-dir nyan pip python urltools wakeonlan web-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

#fix issues with interpreting scp, etc. paths as globs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
zstyle -e :urlglobber url-other-schema '[[ $words[1] == scp ]] && reply=("*") || reply=(http https ftp)'

export EDITOR="$ZSH/editor.sh"

# Load powerline (location depends on architecture)
# TODO: move this into a plugin
POWERLINE_PATH="$(pip show powerline-status | awk '/Location/{print $2;}')/powerline/bindings/zsh/powerline.zsh"
TTY="$(tty | awk -F/ '{print $3;}')"
VIRTUAL_ENV_DISABLE_PROMPT=1    #powerline tells us what the virtualenv is, so we don't want virtualenv to change the prompt

[ ! -r $POWERLINE_PATH ] && [ -f /usr/share/zsh/site-contrib/powerline.zsh ] && POWERLINE_PATH="/usr/share/zsh/site-contrib/powerline.zsh"

[ -f /etc/vconsole.conf ] && source /etc/vconsole.conf
if [[ ! -r $POWERLINE_PATH ]] ; then
    echo "Powerline is not installed."
    POWERLINE_PATH="/dev/null"
elif [ "$TTY" != "pts" -a "$FONT" != "eurlatgr" ]; then
    # We need a console font that supports unicode
    echo "Running on $(tty) with unsupported font. Please edit /etc/vconsole.conf to use eurlatgr."
    setfont eurlatgr
fi

source $POWERLINE_PATH

unset FONT
unset KEYMAP
unset POWERLINE_PATH TTY

# Check that snapshots are working. This really shouldn't be necessary, but I've been screwed over by this too many times...
if [[ -f ~/Backups/.last_snapshot ]]; then
    BACKUP_FILE="~/Backups/.last_snapshot"
elif [[ -f /home/snapshots/.last_snapshot ]]; then
    BACKUP_FILE="/home/snapshots/.last_snapshot"
fi

if [[ ! -r $BACKUP_FILE ]]; then
    AGE=$(echo "scale=2; ($(date +%s) - $(date +%s -r ~/Backups/.last_snapshot)) / (60*60*24)" | bc)

    if [[ $(echo "$AGE > 2" | bc) == 1 ]]; then
        echo "$fg_bold[red]WARNING: Most recent snapshot is $AGE days old.$reset_color"
    fi

else
    echo "$fg_bold[red]WARNING: Snapshots not found.$reset_color"
fi

unset BACKUP_FILE

#Force 256 colour support (needed for tmux)
 [[ "$TERM" == "xterm" ]] && export TERM="xterm-256color"

# Load Jmake autocompletion
[ -d $HOME/.jmake ] && source $HOME/.jmake/completion/jmake.completion.zsh

# AWS CLI support
[ -d ~/sources/awscli-saml-auth ] && source $HOME/sources/awscli-saml-auth/zshrc_additions

# Load work key
[ -f /media/Work/ssh-key/load.sh ] && source /media/Work/ssh-key/load.sh
