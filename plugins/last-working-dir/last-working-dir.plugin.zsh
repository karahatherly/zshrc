#!/usr/bin/env zsh
# Keeps track of the last used working directory and automatically jumps
# into it for new shells.

# Flag indicating if we've previously jumped to last directory.
typeset -g ZSH_LAST_WORKING_DIRECTORY
mkdir -p "$ZSH/cache"
local cache_file="$ZSH/cache/last-working-dir"

# Updates the last directory once directory is changed.
function chpwd() {
  # Use >| in case noclobber is set to avoid "file exists" error
	pwd >| "$cache_file"
}

# Changes directory to the last working directory.
function lwd() {
	[[ ! -r "$cache_file" ]] || cd `cat "$cache_file"`
}

# Automatically jump to last working directory unless this isn't the first time
# this plugin has been loaded, or we're in something that's not primarily a terminal
local terminal_name="$(ps hp $(ps hp $$ -o ppid) -o comm)"

if [[ -z "$ZSH_LAST_WORKING_DIRECTORY" ]] && [[ "$terminal_name" != "dolphin" ]] && [[ "$terminal_name" != "kate" ]]; then
	lwd 2>/dev/null && ZSH_LAST_WORKING_DIRECTORY=1 || true
fi

#clear on exit if in the folder. This allows us to use Ctrl+D as a fast way to return to $HOME.
function zshexit(){
    [[ -r "$cache_file" ]] && [[ "$(cat $cache_file)" == "$(pwd)" ]] && rm "$cache_file"
}
