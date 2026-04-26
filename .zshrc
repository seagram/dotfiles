# aliases
alias ls='eza --color=always --oneline --icons=always --group-directories-first'
alias tree='eza --tree --color=always --icons=always --group-directories-first --git-ignore'
alias sz="exec zsh"
alias c="clear"
alias e="exit"
alias t="tmux"
alias v="nvim"
alias lv=$'nvim -c "normal \'0"'
alias dot="cd ~/github/dotfiles/ && stow --ignore='\.DS_Store' -t ~/ ."
alias repo="open \$(git remote get-url origin) || echo 'no remote found'"
alias lg="lazygit"
alias mr="mise run"
alias me="mise exec --"
alias ts="tailscale"
alias ff="fastfetch"

# exports
export VISUAL="nvim"
export EDITOR="nvim"
export BROWSER="open -a Helium"
export CLICOLOR=YES

# options
stty -ixon
setopt vi
bindkey -v '^?' backward-delete-char
setopt auto_param_slash
setopt no_case_glob no_case_match
unsetopt prompt_sp
setopt autocd

# keys
source ~/.keys

# optimize completion init
zmodload zsh/datetime zsh/stat
autoload -Uz compinit
zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if zstat -A zcompdump_mtime +mtime -- "$zcompdump" 2>/dev/null && (( EPOCHSECONDS - zcompdump_mtime[1] < 86400 )); then
    compinit -C -d "$zcompdump"
else
    compinit -d "$zcompdump"
fi

# zstyle
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
zstyle ':completion:*' squeeze-slashes false # explicit disable to allow /*/ expansion

# zsh history setup
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
HISTFILE=$HOME/.zhistory
setopt inc_append_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# native zsh-syntax-highlighting
autoload -Uz add-zle-hook-widget
_highlight_command() {
    region_highlight=()
    local cmd="${BUFFER%% *}"
    if [[ -n "$cmd" ]] && type "$cmd" &>/dev/null; then
        region_highlight+=("0 ${#cmd} fg=02")
    fi
}
add-zle-hook-widget line-pre-redraw _highlight_command

# homebrew
export HOMEBREW_NO_ENV_HINTS=TRUE
export HOMEBREW_CASK_OPTS=--no-quarantine
alias bu="brew upgrade"
alias ba="brew autoremove -v && brew cleanup -s --prune=all -v"
alias bt='brew deps --tree $(brew leaves)'
alias bf="brew bundle dump --file=~/github/dotfiles/.config/brew/Brewfile --force --brews --casks"

# carapace
source <(carapace _carapace zsh)

# zoxide
alias cd="z"
eval "$(zoxide init zsh)"

# starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# eza
export EZA_CONFIG_DIR=~/.config/eza/

# fzf
export FZF_DEFAULT_COMMAND='fd --type d . ~'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/config
source <(fzf --zsh)

# mise
eval "$(mise activate zsh)"
