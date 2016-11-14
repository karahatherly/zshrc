# Load Jmake autocompletion
[ -d $HOME/.jmake ] && source $HOME/.jmake/completion/jmake.completion.zsh

# AWS CLI support
[ -d ~/sources/awscli-saml-auth ] && source $HOME/sources/awscli-saml-auth/zshrc_additions


# Aliases for grepping POMs / plugin.xml
alias pom-grep="find . -iname pom.xml -print0 | xargs -0 -r ag"
alias plugin-grep="find . -iname atlassian-plugin.xml -print0 | xargs -0 -r ag"

# Aliases for connecting to Postgres in a docker container (started by jmake)
alias pg-docker="./jmake postgres docker"
alias pgcli-docker="pgcli -h localhost -p 5433 jira jira"

# Jira quick compile
# TODO: replace with function
alias jqc="(cd jira-components/jira-api && mvn clean install -DskipTests && cd ../jira-core && mvn clean install -DskipTests)"

