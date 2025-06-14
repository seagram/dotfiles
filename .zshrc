# command prompt
PROMPT="%F{049}%1~%f "

# editor
export EDITOR="nvim"
export VISUAL="$EDITOR"

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

# history-based completion using arrow keys
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]='none'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=051'

# zsh-autosugesstions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^L' autosuggest-execute

# lsd
export CLICOLOR=YES
# match ls_color number to corresponding palette number in ghostty config
export LS_COLORS='di=96:ln=37:so=37:pi=37:ex=92:bd=37:cd=37:su=37:sg=37:tw=37:ow=37'

# commands
alias ls="lsd"
alias sz="source ~/.zshrc"
alias c="clear"
alias e="exit"

# homebrew
export HOMEBREW_NO_ENV_HINTS=TRUE
export HOMEBREW_CASK_OPTS=--no-quarantine
export HOMEBREW_NO_UPDATE_REPORT_FORMULAE=TRUE
export HOMEBREW_NO_UPDATE_REPORT_CASKS=TRUE
alias bd="brew deps --tree --installed --formula"
alias bu="brew upgrade"
alias bc="brew list --casks"
alias bl="brew leaves"
alias ba="brew autoremove -v && brew cleanup -s --prune=all -v"

# neovim
alias vim="nvim"
alias v="nvim"
alias lv="vim -c \"normal '0\""

# git
alias gs="git status --short"
alias gd="git diff --output-indicator-new=' ' --output-indicator-old=' '"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gu="git pull"
alias gl="git log --all --graph"
alias gb="git branch"
alias gi="git init"
alias gc="gi clone"

# go
export PATH=$(go env GOPATH)/bin:$PATH

# lazygit
alias lg="lazygit"
export XDG_CONFIG_HOME="$HOME/.config"

# zoxide
alias cd="z"
eval "$(zoxide init zsh)"

# yazi
alias l="y"
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# fnm
eval "$(fnm env --use-on-cd --shell zsh)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/callumairlie/.bun/_bun" ] && source "/Users/callumairlie/.bun/_bun"

# pnpm
export PNPM_HOME="/Users/callumairlie/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

alias yt-dlp="/Users/callumairlie/.yt-dlp"
alias yt-audio='yt-dlp -f ba -x --audio-format aac'
alias yt-video="yt-dlp \"\$@\" -f 'bv*[height=1080]+ba'"

# uv
export PATH="~/.local/bin:$PATH"

# lazysql
alias lsql="lazysql"
