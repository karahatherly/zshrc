# Install antidote bundles
source "$HOME/.zsh/.antidote/antidote.zsh"

if (cmd_exists antidote); then
    source <(antidote init)

    antidote bundle <<EOF
        zsh-users/zsh-completions
        zsh-users/zsh-autosuggestions
        zsh-users/zsh-syntax-highlighting
        zsh-users/zsh-history-substring-search
        MichaelAquilina/zsh-you-should-use
EOF
else
    echo "Antidote not installed" >&2
fi
