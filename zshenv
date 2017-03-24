ZSH=$HOME/.zsh

# Local binaries
# Note that PATH changes will not affect root, because this script is sourced before /etc/zsh/zprofile
PATH="$HOME/.local/bin:$HOME/bin:${PATH}"

# Android SDK path
PATH="$HOME/bin/android-sdk-linux/platform-tools:${PATH}"

# Environment
EDITOR="$ZSH/bin/editor.sh"
VISUAL="$ZSH/bin/editor.sh"
TERMINAL=/usr/bin/konsole

# Fix for broken ls behaviour
QUOTING_STYLE=literal

# This fixes xdg-open
export KDE_SESSION_VERSION=5

#Force 256 colour support (needed for tmux)
 [[ "$TERM" == "xterm" ]] && export TERM="xterm-256color"

