# Install anitbody bundles

if (cmd_exists antibody); then
    source <(antibody init)

    antibody bundle <<EOF
        zsh-users/zsh-completions
        zsh-users/zsh-autosuggestions
        zsh-users/zsh-syntax-highlighting
        zsh-users/zsh-history-substring-search
        MichaelAquilina/zsh-you-should-use
EOF
else
    echo "Antibody not installed" >&2
fi
