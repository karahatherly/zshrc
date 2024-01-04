# Based on https://github.com/powerline/powerline/blob/develop/powerline/bindings/zsh/powerline.zsh
# Inlining it here eliminates the runtime dependency on the powerline package

_powerline_set_jobnum() {
	# If you are wondering why I am not using the same code as I use for bash
	# ($(jobs|wc -l)): consider the following test:
	#     echo abc | less
	#     <C-z>
	# . This way jobs will print
	#     [1]  + done       echo abc |
	#            suspended  less -M
	# ([ is in first column). You see: any line counting thingie will return
	# wrong number of jobs. You need to filter the lines first. Or not use
	# jobs built-in at all.
	integer -g _POWERLINE_JOBNUM=${(%):-%j}
}

_powerline_columns_fallback() {
	if (cmd_exists stty) then
		local cols="$(stty size 2>/dev/null)"
		if ! test -z "$cols" ; then
			echo "${cols#* }"
			return 0
		fi
	fi
	echo 0
	return 0
}

# Configure shell
setopt promptpercent
setopt promptsubst

# Setup prompt
if which powerline-hs &>/dev/null ; then
    precmd_functions+=( _powerline_set_jobnum )
    typeset -g VIRTUAL_ENV_DISABLE_PROMPT=1
    local POWERLINE_COMMAND=powerline-hs

    local add_args='-r .zsh'
    add_args+=' --last-exit-code=$?'
    add_args+=' --last-pipe-status="$pipestatus"'
    add_args+=' --renderer-arg="client_id=$$"'
    add_args+=' --renderer-arg="shortened_path=${(%):-%~}"'
    add_args+=' --jobnum=$_POWERLINE_JOBNUM'
    add_args+=' --renderer-arg="mode=$_POWERLINE_MODE"'
    add_args+=' --renderer-arg="default_mode=$_POWERLINE_DEFAULT_MODE"'
    local new_args_2=' --renderer-arg="parser_state=${(%%):-%_}"'
    new_args_2+=' --renderer-arg="local_theme=continuation"'
    local add_args_3=$add_args' --renderer-arg="local_theme=select"'
    local add_args_2=$add_args$new_args_2
    add_args+=' --width=$(( ${COLUMNS:-$(_powerline_columns_fallback)} - ${ZLE_RPROMPT_INDENT:-1} ))'
    local add_args_r2=$add_args$new_args_2

    # Set the prompts
    typeset -g PS1='$("$POWERLINE_COMMAND" $=POWERLINE_COMMAND_ARGS shell aboveleft '$add_args')'
    typeset -g RPS1='$("$POWERLINE_COMMAND" $=POWERLINE_COMMAND_ARGS shell right '$add_args')'
    typeset -g PS2='$("$POWERLINE_COMMAND" $=POWERLINE_COMMAND_ARGS shell left '$add_args_2')'
    typeset -g RPS2='$("$POWERLINE_COMMAND" $=POWERLINE_COMMAND_ARGS shell right '$add_args_r2')'
    typeset -g PS3='$("$POWERLINE_COMMAND" $=POWERLINE_COMMAND_ARGS shell left '$add_args_3')'

else
    echo "WARN: Could not find powerline-hs" >/dev/stderr
fi

