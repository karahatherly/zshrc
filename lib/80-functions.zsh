function take() {
  mkdir -p $1
  cd $1
}

function fv(){
    # Function for selecting a file with fzf & opening it in $EDITOR

    # use git for listing files if possible, for performance and convenience
    if /usr/bin/git rev-parse --git-dir &>/dev/null ; then
        export FZF_DEFAULT_COMMAND="/usr/bin/git ls-tree -r --name-only HEAD"
    fi

    $EDITOR "$(fzf)"
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

# Function for using perl as grep
function pgrep() {
    REGEX="$1"
    shift

    # If a capture was used print its contents, else print the entire match
    # This lets us avoid using lookahead/lookbehind assertions, one of the most common reasons for wanting perl
    perl -lne "/$REGEX/ and print ( defined \$1 ? \$1 : $&);" "$@"
}

