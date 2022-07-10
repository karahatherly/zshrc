## Command history configuration
HISTFILE=$ZSH/history

HISTSIZE=10000
SAVEHIST=10000

# Show history with ISO format timestamp
alias history='fc -il 1'

# Append to history files, rather than overwriting. Needed for simulataneous shells.
setopt append_history

# ... and do so on each command, rather than shell exit.
setopt inc_append_history

# Import commands from the history file.
setopt share_history

# Save with timestamp
setopt extended_history

# Drop duplicates first
setopt hist_expire_dups_first
setopt hist_ignore_dups

# Don't save commands prefixed with a space
setopt hist_ignore_space

# When selecting a past command, load into the editing buffer rather than executing immediately
setopt hist_verify

