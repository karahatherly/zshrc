ZSH=$HOME/.zsh

# Local binaries
# Note that PATH changes will not affect root, because this script is sourced before /etc/zsh/zprofile
PATH="$HOME/.local/bin:$HOME/bin:${PATH}"

# Android SDK path
PATH="$HOME/bin/android-sdk-linux/platform-tools:${PATH}"

# Environment
export EDITOR="nvim"
export VISUAL="nvim"
TERMINAL=/usr/bin/konsole

# Fix for broken ls behaviour
QUOTING_STYLE=literal

# This fixes xdg-open
export KDE_SESSION_VERSION=5

# Make zsh-you-should-use only show the longest matching alias
YSU_MODE=BESTMATCH

#Force 256 colour support (needed for tmux)
 [[ "$TERM" == "xterm" ]] && export TERM="xterm-256color"

# Used by Jmake CI
export JIRA_REPO="$HOME/jira-master"

# Set SWAYSOCK if unset
if [[ -z "${SWAYSOCK-}" ]] && pgrep -x sway >/dev/null ; then
    export SWAYSOCK="/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock"
fi

# Set MAKEOPTS intelligently, so that we use the appropriate number of cores.
# We use both -j and -l to handle 
CPU_COUNT="$(lscpu -p | grep -cv '^#')"
export MAKEOPTS="-j ${CPU_COUNT} -l ${CPU_COUNT}"

# Used in sway config for host-specific configuration
export HOST="$(hostname)"


# Use jenv
if [ -d ~/.jenv/ ] ; then
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
fi
