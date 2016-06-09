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

function share-with-kooky(){
    # function for sharing files with kooky
    chown -Rv reuben:users $@
    chmod -Rv g=u $@
}

function gcp(){
    # function for copying local git repos while preserving remotes
    LOCAL="$2"

    echo "WARNING: using --shared (don't rebase/delete the source repo!)"
    git clone --shared $@

    if [[ -z $LOCAL ]]; then
        LOCAL=$(basename "$1")
    fi

    if [ -f "$1/.git/config"  ]; then
        echo "Copying git config"
        cp "$1/.git/config" "$LOCAL/.git/config"
    elif [ -f "$1/config"  ]; then
        # assume bare repo with config file
        echo "Copying git config (bare)"
        cp "$1/config" "$LOCAL/.git/config"
        git -C "$LOCAL" config --unset core.bare
        sed -i -e '/mirror = true/d' -e '/fetch =/d' "$LOCAL/.git/config"
    else
        # assume bare repo
        echo "Copying remote"
        git -C "$LOCAL" remote set-url origin $(git -C "$1" remote -v | awk '/^origin/{print $2}' | head -n1)
    fi

    # if Java project, configure word diffs
    if [ -f "$LOCAL/pom.xml" ]; then
        echo '*.java diff=cpp' >> "$LOCAL/.git/attributes"
    fi

    # checkout branch if it looks like an issue
    BRANCH=$(basename "$LOCAL")

    if [[ "$BRANCH" == JVS* || "$BRANCH" == JDEV* ]] ; then
        git -C "$LOCAL" checkout -b "issue/$BRANCH"

        # this should be doable without config hackery, but I couldn't get it to work
        git -C "$LOCAL" config --local --add branch."issue/$BRANCH".remote origin
        git -C "$LOCAL" config --local --add branch."issue/$BRANCH".merge refs/heads/issue/$BRANCH
    fi

    cd "$LOCAL"
}

function fv(){
    # use git for listing files if possible, for performance and convenience
    if /usr/bin/git rev-parse --git-dir &>/dev/null ; then
        export FZF_DEFAULT_COMMAND="/usr/bin/git ls-tree -r --name-only HEAD"
    fi

    $EDITOR "$(fzf)"
    unset FZF_DEFAULT_COMMAND
}

function gcof(){
    SELECTION=$(git show-ref | sed 's|refs/||' | fzf)
    HASH=$(echo "$SELECTION" | awk '{print $1}')
    REF=$(echo "$SELECTION"  | awk '{print $2}')
    REF_TYPE=$(echo "$REF"   | cut -d/ -f1)
    REF_NAME=$(echo "$REF"   | cut -d/ -f2-)

    if [[ "$REF_TYPE" == "remotes" ]] ; then
        # Remote branch - need to explicitly setup tracking
        # e.g. origin/issue/JDEV-XXXX-foo
        REMOTE=$(echo "$REF" | cut -d/ -f2)
        BRANCH=$(echo "$REF" | cut -d/ -f3-)

        echo "$BRANCH, $REF_NAME, $REMOTE"
        git checkout -b "$BRANCH" "$HASH"
        git config --local --add branch."$BRANCH".remote "$REMOTE"
        git config --local --add branch."$BRANCH".merge refs/heads/$BRANCH

    elif [[ "$REF_TYPE" == "heads" ]]; then
        git checkout "$REF_NAME"

    elif [[ "$REF_TYPE" == "tags" ]]; then
        git checkout -b "$REF_NAME" "$HASH"

    else
        echo "Unknown ref type: $REF_TYPE" >&2
        exit 1
    fi
}
