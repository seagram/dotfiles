# command prompt
PROMPT="%F{049}%1~%f "

# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]='none'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=051'

# lsd colours
export CLICOLOR=YES
export LS_COLORS=di=36:ln=37:so=37:pi=37:ex=32:bd=37:cd=37:su=37:sg=37:tw=37:ow=37

# homebrew
export HOMEBREW_NO_ENV_HINTS=TRUE
export HOMEBREW_CASK_OPTS=--no-quarantine
export HOMEBREW_NO_UPDATE_REPORT_FORMULAE=TRUE
export HOMEBREW_NO_UPDATE_REPORT_CASKS=TRUE

# neovim
alias vim="nvim"
alias v="nvim"
alias lv="vim -c \"normal '0\""

# commands
alias ls="lsd"
alias sz="source ~/.zshrc"
alias c="clear"
alias e="exit"

# lazygit
alias lg="lazygit"
export XDG_CONFIG_HOME="$HOME/.config"

# homebrew
alias deps="brew deps --tree --installed"
alias bu="brew upgrade"

# zoxide
alias cd="z"
eval "$(zoxide init zsh)"

# zsh history setup
HISTSIZE=200
HISTFILE=$HOME/.zhistory
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory 
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# zsh-autosugesstions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^L' autosuggest-execute

# yt-dlp
export PATH="/usr/local/bin:$PATH"
alias ytdlp="yt-dlp -P ~/Music/youtube -f 140"
