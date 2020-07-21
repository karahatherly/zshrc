# Load Jmake autocompletion
[ -d $HOME/.jmake ] && source $HOME/.jmake/completion/jmake.completion.zsh

# AWS CLI support
[ -d ~/sources/awscli-saml-auth ] && source $HOME/sources/awscli-saml-auth/zshrc_additions

# LaaS CLI support
[ -f /usr/share/zsh/site-functions/_laas ] && source /usr/share/zsh/site-functions/_laas

# Helper function for work laptop
function reinit_peripherals() {
    autorandr

    nmcli --ask con up "Ethernet (Atlassian)" || nmtui

    # Check for missing wifi firmware
    journalctl -b 0 -k -p warning | grep --color=always iwlwifi

    numlockx on
}


# Aliases for grepping POMs / plugin.xml
alias pom-grep="git ls-files pom.xml '**/pom.xml' | xargs -r ag"
alias plugin-grep="find . -iname atlassian-plugin.xml -print0 | xargs -0 -r ag"
alias cd-migrations='cd ./jira-components/jira-core/src/main/resources/db/platform/migrations/'
alias purge-snapshots="find ~/.m2/repository -iname 1001.0.0-SNAPSHOT -print0 | xargs -0 rm -rfv"

# Aliases for connecting to Postgres in a docker container (started by jmake)
alias pg-docker="./jmake postgres"
alias pg-docker-restart="pg-docker stop; pg-docker start $@"
alias pg-purge='docker rm -f $(cat docker.cid)'
alias pgcli-docker="pgcli -h localhost -p 5433 jira jira"
alias pgcli-d="pgcli -h localhost -p 5433 -U jira -d "
alias psql-docker="psql -h localhost -p 5433 jira jira"
alias psql-d="psql -h localhost -p 5433 -U jira -d "
alias pgcli-sis='pgcli -h localhost -p 5435 postgres postgres'
alias docker-cleanup='docker rm $(docker ps -a | awk "/Exited/{print $1}")'
alias mci='mvn clean install -DskipTests'
alias mcp='mvn clean package -DskipTests'

alias jmake_alpha='export JMAKE_VERSION=$(xpath -q -e "/project/version/text()" ~/jmake/pom.xml)'

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


function bamboo_creds() {
    CON=/etc/NetworkManager/system-connections/Charlie
    export BAMBOO_USERNAME=$(sudo awk -F= '($1 == "identity"){print $2}' $CON)
    export BAMBOO_PASSWORD=$(sudo awk -F= '($1 == "password"){print $2}' $CON)
}
