# check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
      git clone https://github.com/zplug/zplug ~/.zplug
        source ~/.zplug/init.zsh && zplug update --self
fi

# load zplug
source ~/.zplug/init.zsh

zplug "jimmijj/zsh-syntax-highlighting", defer:2
zplug "rupa/z", use:z.sh
zplug "zsh-users/zsh-history-substring-search"
zplug "tarruda/zsh-autosuggestions"
zplug "zsh-users/zsh-completions", lazy:true

# antigen oh-my-zsh features
zplug "plugins/git", from:oh-my-zsh, lazy:true
zplug "plugins/python", from:oh-my-zsh, lazy:true
# zplug "plugins/dnf", from:oh-my-zsh, lazy:true
zplug "plugins/git-extras", from:oh-my-zsh
# zplug "plugins/jira", from:oh-my-zsh, lazy:true
zplug "plugins/pip", from:oh-my-zsh, lazy:true
# zplug "plugins/sbt", from:oh-my-zsh, lazy:true
zplug "plugins/cargo", from:oh-my-zsh, lazy:true
# zplug "plugins/scala", from:oh-my-zsh, lazy:true
# zplug "plugins/sudo", from:oh-my-zsh, lazy:true
zplug "plugins/systemd", from:oh-my-zsh, lazy:true
zplug "plugins/vagrant", from:oh-my-zsh, lazy:true
zplug "plugins/rsync", from:oh-my-zsh, lazy:true
zplug "plugins/ubuntu", from:oh-my-zsh, lazy:true
zplug "plugins/yarn", from:oh-my-zsh, lazy:true
# zplug "plugins/web-search", from:oh-my-zsh, lazy:true
# zplug "plugins/colored-man-pages", from:oh-my-zsh, lazy:true
zplug "skroll/zsh-cmake-completion", lazy:true
zplug "pkulev/zsh-rustup-completion", lazy:true
zplug "themes/robbyrussell", from:oh-my-zsh, as:theme
zplug "supercrabtree/k"
zplug 'zplug/zplug', hook-build:'zplug --self-manage'


# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

# load plugins
zplug load

# completion
autoload -U compinit
compinit

# autosuggest
# zle-line-init() {
#   zle autosuggest-start
# }
# zle -N zle-line-init

# correction
# setopt correctall

# qfc
#[[ -s "$HOME/.qfc/bin/qfc.sh" ]] && source "$HOME/.qfc/bin/qfc.sh"

# bind UP and DOWN arrow keys
zmodload zsh/terminfo

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
#
# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
#
# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
#
# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export BROWSER=chrome

# disable ctrl-s XOFF feature
stty -ixon

# start fuzzy searcher and open result in vim
vo() {
  local files=($(find -L . | fzf-tmux --select-1 --exit-0 $1))
  if [[ ! -z ${files} ]]; then
    ${EDITOR:-vim} "${files[@]}"
  fi 
}

# open class from last project, TODO
# vc() {
#   local class=($(rc -S class | fzf-tmux --select-1 --exit-0 --query="$1"))
#   local files=($(rc -F "${class}" --definition-only -K | head -n 1))
#   local file=($(echo "${files}" | sed 's/:.*//'))
#   local line=($(echo "${files}" | sed 's/.*:\([0-9]\+\):[0-9]\+.*/\1/'))
#   local offset=($(echo "${files}" | sed 's/.*:\([0-9]\+\):\([0-9]\+\).*/\2/'))
#   # echo ${files[@]}
#   # echo $file
#   # echo $line
#   # echo $offset
#   if [[ ! -z ${file} ]]; then
#     ${EDITOR:-vim} ${file} +$line
#   fi
# }

# open class from last project, TODO
# vs() {
#   local class=($(rc -S --imenu | fzf-tmux --select-1 --exit-0 --query="$1"))
#   local files=($(rc -F "${class}" --definition-only -K | head -n 1))
#   local file=($(echo "${files}" | sed 's/:.*//'))
#   local line=($(echo "${files}" | sed 's/.*:\([0-9]\+\):[0-9]\+.*/\1/'))
#   local offset=($(echo "${files}" | sed 's/.*:\([0-9]\+\):\([0-9]\+\).*/\2/'))
#   # echo ${files[@]}
#   # echo $file
#   # echo $line
#   # echo $offset
#   if [[ ! -z ${file} ]]; then
#     ${EDITOR:-vim} ${file} +$line
#   fi
# }

# z integartion
unalias z 2> /dev/null
z() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
  else
    _z "$@"
  fi
}

ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
      tmux select-window -t $target_window
  fi
}

# vim() { vimx --servername debug "$*"; }
# vi() { vimx --servername debug "$*"; }

export _JAVA_OPTIONS="-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dsun.java2d.uiScale=2.0"
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/snap/bin

SAVEHIST=1000
HISTFILE=~/.zsh_history
GCC_COLORS=1

eval "$(keychain --eval --agents ssh,gpg)"
