#zshrc is only executed for interactive shells, but this is always executed

#Android SDK path
PATH="$HOME/bin/android-sdk-linux/platform-tools:$HOME/bin/android-sdk-linux/build-tools/24.0.0/:${PATH}"

# Atlassian sdk
PATH="/opt/atlassian-plugin-sdk/bin:${PATH}"

#Haskell Cabal support
PATH="$HOME/.cabal/bin:${PATH}"

PATH="$HOME/.local/bin:$HOME/bin:${PATH}"

#Aliases
source $HOME/.oh-my-zsh/lib/aliases.zsh

export TERMINAL=/usr/bin/konsole
export QUOTING_STYLE=literal

