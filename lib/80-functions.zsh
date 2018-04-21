function take() {
  mkdir -p $1
  cd $1
}

function share-with-kooky(){
    # function for sharing files with kooky
    chown -Rv reuben:users $@
    chmod -Rv g=u $@
}

function gclr(){
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
    git tag root
}

function fv(){
    # Function for selecting a file with fzf & opening it in $EDITOR

    # use git for listing files if possible, for performance and convenience
    if /usr/bin/git rev-parse --git-dir &>/dev/null ; then
        export FZF_DEFAULT_COMMAND="/usr/bin/git ls-tree -r --name-only HEAD"
    fi

    $EDITOR "$(fzf)" &
    unset FZF_DEFAULT_COMMAND
}

function gcof(){
    # Function for selecting with fzf a red and checking it out
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

function new-agent() {
    ssh-agent > /tmp/.ssh-agent
    source /tmp/.ssh-agent
    ssh-add ~/.ssh/id_rsa
}

function vfio-groups() {
    for d in /sys/kernel/iommu_groups/*/devices/*; do
        n=${d#*/iommu_groups/*}; n=${n%%/*}
        printf 'IOMMU Group %s ' "$n"
        lspci -nns "${d##*/}"
    done;
}

