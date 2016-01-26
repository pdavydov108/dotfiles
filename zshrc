# antigen
source ~/antigen.zsh

# completion
autoload -U compinit
compinit

# antigen plugins
antigen bundle robbyrussell/oh-my-zsh lib/
antigen bundle zsh-users/zsh-completions src/
antigen bundle jimmijj/zsh-syntax-highlighting
#source ~/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-history-substring-search.git/zsh-history-substring-search.zsh

antigen bundle zsh-users/zsh-history-substring-search
# antigen bundle tarruda/zsh-autosuggestions

# antigen oh-my-zsh features
antigen bundle git
antigen bundle pip
antigen bundle python
antigen bundle zsh-completions

# antigen oh-my-zsh theme
antigen theme norm

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
