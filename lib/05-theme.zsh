# Gentoo theme
# This is only a fallback - it will normally be overwritten by Powerline

function prompt_char {
	if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n@)%m %{$fg_bold[blue]%}%(!.%1~.%~) %_$(prompt_char)%{$reset_color%} '

