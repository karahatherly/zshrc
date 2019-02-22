if (cmd_exists fasd); then
    # This defines some aliases we might not want, so do it first to ensure they get overriden.
    eval "$(fasd --init auto)"

    # For compatibliity with autojump
    alias j=z
else
    echo "Fasd is not installed" >&2
fi

