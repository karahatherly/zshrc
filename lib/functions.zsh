function zsh_stats() {
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

function uninstall_oh_my_zsh() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/uninstall.sh
}

function upgrade_oh_my_zsh() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/upgrade.sh
}

function take() {
  mkdir -p $1
  cd $1
}

function vless() {
    export VLESS_PAGE="less"
    vcat "$1" "$2"
    unset VLESS_PAGE
}

function vcat() {
    #USAGE: vcat [-n] FILE FORMAT
    export OUTPUT=$(tempfile)
    export LINE_NO=0

    if [[ "$1" == "-n" ]] ; then
        export LINE_NO=1
        shift
    fi

    export FILE_FORMAT="$2"
    vim -R -u ~/.vim/tohtml "$1"
    elinks -dump -dump-color-mode 1 -no-references $OUTPUT | sed 's/ //' | ${VLESS_PAGE:-cat}
    /bin/rm $OUTPUT
    unset OUTPUT FILE_FORMAT
}

function ack(){
    # function that prefers git-grep where possible, since it's faster

    if git rev-parse --is-inside-work-tree &>/dev/null ; then
        git grep -n -C 2 --heading --break $@
    else
        # Magic options that let less quit for output of less than one page
        # (contents show up in scroll buffer though, so it's not a good default)
        LESS="-RFX" ag --pager=less $@
    fi
}
