# Helper function that checks if a command exists without forking
function cmd_exists {
    command -v $@ >/dev/null
}

