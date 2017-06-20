# Load Jmake autocompletion
[ -d $HOME/.jmake ] && source $HOME/.jmake/completion/jmake.completion.zsh

# AWS CLI support
[ -d ~/sources/awscli-saml-auth ] && source $HOME/sources/awscli-saml-auth/zshrc_additions

# LaaS CLI support
[ -f /usr/share/zsh/site-functions/_laas ] && source /usr/share/zsh/site-functions/_laas

# Helper function for work laptop
function reinit_peripherals() {
    nmcli con up "Ethernet (Atlassian)" || nmtui

    # Check for missing wifi firmware
    journalctl -b 0 -k -p warning | grep --color=always iwlwifi

    numlockx on
    xmodmap -e "remove Lock = Caps_Lock"
    xmodmap -e "keysym Caps_Lock = Escape"
    xmodmap -e "keysym XF86Tools = Insert"
    echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
}


# Aliases for grepping POMs / plugin.xml
alias pom-grep="find . -iname pom.xml -print0 | xargs -0 -r ag"
alias plugin-grep="find . -iname atlassian-plugin.xml -print0 | xargs -0 -r ag"

# Aliases for connecting to Postgres in a docker container (started by jmake)
alias pg-docker="./jmake postgres docker"
alias pg-purge='docker rm -f $(cat docker.cid)'
alias pgcli-docker="pgcli -h localhost -p 5433 jira jira"
alias psql-docker="psql -h localhost -p 5433 jira jira"
alias docker-cleanup='docker rm $(docker ps -a | awk "/Exited/{print $1}")'
alias mci='mvn clean install -DskipTests'

# Aliases for starting JIRA
alias jinstall="nice ./jmake install --frontend-skip"

alias jdbg="nice ./jmake debug --db DOCKER -J-Djira.webresource.local.caching=true --frontend-skip"
alias jdbg-indexprimary='jdbg -J-Djira.instrumentation.laas=true -J-Datlassian.darkfeature.jira.issue.search.api.indexprimary.enabled=true'
alias jdbg-dbprimary='jdbg -J-Djira.instrumentation.laas=true -J-Datlassian.darkfeature.jira.issue.search.api.databaseprimary.enabled=true'
alias jdbg-dbonly='jdbg -J-Djira.instrumentation.laas=true -J-Datlassian.darkfeature.jira.issue.search.api.databaseonly.enabled=true'
alias jdbg-vertigo="jdbg -J-Dsearch.vertigo.mode=true"

alias jqdbg="./jmake debug quickstart --db DOCKER -J-Djira.webresource.local.caching=true"
alias jqdbg-indexprimary='jqdbg -J-Djira.instrumentation.laas=true -J-Datlassian.darkfeature.jira.issue.search.api.indexprimary.enabled=true'
alias jqdbg-dbprimary='jqdbg -J-Djira.instrumentation.laas=true -J-Datlassian.darkfeature.jira.issue.search.api.databaseprimary.enabled=true'
alias jqdbg-dbonly='jqdbg -J-Djira.instrumentation.laas=true -J-Datlassian.darkfeature.jira.issue.search.api.databaseonly.enabled=true'
alias jqdbg-vertigo="jqdbg -J-Dsearch.vertigo.mode=true"

# go/build-status-in-a-shell
alias builds='$HOME/sources/build-status-in-a-shell/cli/build-status.py --list'

# Jira quick compile
function jqc() {
    [ ! -d target ] && mvn initialize

    pushd jira-components/jira-api
    mvn clean install -DskipTests
    cd ../jira-core
    mvn clean install -DskipTests
    popd
}

