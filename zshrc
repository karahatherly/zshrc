# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#NOTE: This is a fallback, since powerline overrides it
ZSH_THEME="gentoo"
#other suggestions: candy, crunch, gianu, jreese, lukerandall, nebirhos, superjarin, bira, josh, 

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git git-extras autojump cp last-working-dir nyan pip python urltools wakeonlan web-search)

source $ZSH/oh-my-zsh.sh

#fix issues with interpreting scp, etc. paths as globs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
zstyle -e :urlglobber url-other-schema '[[ $words[1] == scp ]] && reply=("*") || reply=(http https ftp)'

# Load powerline (location depends on architecture)
POWERLINE_PATH="$(pip show powerline | awk '/Location/{print $2;}')/powerline/bindings/zsh/powerline.zsh"
TTY="$(tty | awk -F/ '{print $3;}')"

if [[ ! -r $POWERLINE_PATH ]] ; then
    echo "Powerline is not installed."
elif [ "$TTY" != "pts" ]; then
    # This should be disabled when not on a virtual terminal, since consoles lack unicode support
    echo "Running on $(tty). Powerline disabled."
else
    source $POWERLINE_PATH
fi

unset POWERLINE_PATH TTY
