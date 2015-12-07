PS1='\[\033[0;34m\]\u@\h:\w\$\[\033[00m\] '

export LESS_TERMCAP_mb=$'\033[01;31m'
export LESS_TERMCAP_md=$'\033[01;38;5;74m'
export LESS_TERMCAP_me=$'\033[0m'
export LESS_TERMCAP_se=$'\033[0m'
export LESS_TERMCAP_so=$'\033[38;5;246m'
export LESS_TERMCAP_ue=$'\033[0m'
export LESS_TERMCAP_us=$'\033[04;38;5;146m'

export EDITOR=vim
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias vi="vim"

export LESSOPEN="| source-highlight %s"
export LESS=' -R '

export MAVEN_OPTS="-Xmx2g -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=512m -Xss2m"

export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin
export CLICOLOR="true"

export RUST_SRC_PATH=/home/pablo/rust/rustc-1.3.0/src
