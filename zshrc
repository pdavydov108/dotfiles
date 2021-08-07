export _JAVA_OPTIONS="-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dsun.java2d.uiScale=2.0"
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/snap/bin

export SAVEHIST=1000
export HISTFILE=~/.zsh_history
export GCC_COLORS=1
export EDITOR=vim
export BROWSER=chrome

if [[ ! -f $HOME/.local/bin/starship ]]; then
    print -P "starship not found, downloading..."
    command curl -fsSL https://starship.rs/install.sh > /tmp/starship_install.sh
    print -P "installing starship..."
    command chmod +x /tmp/starship_install.sh
    command BIN_DIR=$HOME/.local/bin /tmp/starship_install.sh
    print -P "starship installed"
fi
eval "$(starship init zsh)"

eval "$(keychain --eval --agents ssh,gpg)"

autoload -U compinit
compinit
stty -ixon

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit wait lucid for \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    jimmijj/zsh-syntax-highlighting \
    zsh-users/zsh-history-substring-search

### End of Zinit's installer chunk
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
