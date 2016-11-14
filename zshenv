ZSH=$HOME/.zsh

# Android SDK path
PATH="$HOME/bin/android-sdk-linux/platform-tools:${PATH}"

# Local binaries
PATH="$HOME/.local/bin:$HOME/bin:${PATH}"

EDITOR="$ZSH/bin/editor.sh"
TERMINAL=/usr/bin/konsole

# Fix for broken ls behaviour
QUOTING_STYLE=literal

#Force 256 colour support (needed for tmux)
 [[ "$TERM" == "xterm" ]] && export TERM="xterm-256color"

