# antigen
source ~/.antigen.zsh

# completion
autoload -U compinit
compinit

# antigen plugins
antigen bundle robbyrussell/oh-my-zsh lib/
antigen bundle zsh-users/zsh-completions src/
antigen bundle jimmijj/zsh-syntax-highlighting
antigen bundle rupa/z
# source ~/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-history-substring-search.git/zsh-history-substring-search.zsh

antigen bundle zsh-users/zsh-history-substring-search
# antigen bundle tarruda/zsh-autosuggestions

# antigen oh-my-zsh features
antigen bundle git
antigen bundle pip
antigen bundle python
#antigen bundle zsh-completions

# antigen oh-my-zsh theme
antigen theme norm
# antigen theme robbyrussell

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
  ${EDITOR:-vim} "${files[@]}"
}

# open class from last project, TODO
vc() {
  local class=($(rc -S class | fzf-tmux --select-1 --exit-0 --query="$1"))
  local files=($(rc -F "${class}" --definition-only -K | head -n 1))
  local file=($(echo "${files}" | sed 's/:.*//'))
  local line=($(echo "${files}" | sed 's/.*:\([0-9]\+\):[0-9]\+.*/\1/'))
  local offset=($(echo "${files}" | sed 's/.*:\([0-9]\+\):\([0-9]\+\).*/\2/'))
  # echo ${files[@]}
  # echo $file
  # echo $line
  # echo $offset
  ${EDITOR:-vim} ${file} +$line
}

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
