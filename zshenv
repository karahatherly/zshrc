ZSH=$HOME/.zsh

# Local binaries
# Note that PATH changes will not affect root, because this script is sourced before /etc/zsh/zprofile
PATH="$HOME/.local/bin:$HOME/bin:${PATH}"

# Android SDK path
PATH="$HOME/bin/android-sdk-linux/platform-tools:${PATH}"

# Environment
EDITOR="nvim"
VISUAL="nvim"
TERMINAL=/usr/bin/konsole

# Fix for broken ls behaviour
QUOTING_STYLE=literal

# This fixes xdg-open
export KDE_SESSION_VERSION=5

# Make maven less broken
export MAVEN_OPTS="-Xmx1024m -Xms256m "

# Make zsh-you-should-use only show the longest matching alias
YSU_MODE=BESTMATCH

#Force 256 colour support (needed for tmux)
 [[ "$TERM" == "xterm" ]] && export TERM="xterm-256color"

