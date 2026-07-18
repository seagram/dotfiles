# aliases
alias sz="exec zsh"
alias ls='eza --color=always --oneline --icons=always --group-directories-first'
alias tree='eza --tree --color=always --icons=always --group-directories-first --git-ignore'
alias c="clear"
alias e="exit"
alias v="nvim"
alias t="nvim ~/.todo"
alias lv=$'nvim -c "normal \'0"'
alias repo="open \$(git remote get-url origin) || echo 'no remote found'"
alias l="yazi"
alias lg="lazygit"
alias m="mise"
alias mr="mise run"
alias me="mise exec --"
alias mu="mise upgrade"
alias ts="tailscale"
alias tsu="tailscale up"
alias tsd="tailscale down"
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

# zsh
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt always_to_end

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
zstyle ':completion:*' menu no # let fzf-tab own the menu
zstyle ':completion:*:descriptions' format '[%d]' # enable group headers in fzf-tab

# zsh history setup
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
HISTFILE=$HOME/.zhistory
setopt share_history
setopt inc_append_history
setopt hist_reduce_blanks
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
# export HOMEBREW_AUTO_UPDATE_SECS=3600
alias bu="brew update && brew upgrade"
alias ba="brew autoremove -v && brew cleanup -s --prune=all -v"
alias bt='brew deps --tree $(brew leaves)'
alias bf="brew bundle dump --file=~/github/dotfiles/.config/brew/Brewfile --force --brews --casks --no-describe"

# zoxide
alias cd="z"
eval "$(zoxide init zsh)"

# starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# eza
export EZA_CONFIG_DIR=~/.config/eza/

# fzf
fd_roots_file=${XDG_CONFIG_HOME:-$HOME/.config}/fd/roots
fd_roots=($HOME/${^${(f)"$(grep -vE '^\s*(#|$)' $fd_roots_file)"}})
export FZF_DEFAULT_COMMAND="fd --type d . ${(@q)fd_roots}"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/config
source <(fzf --zsh)

# fzf-tab (after compinit, carapace, and fzf --zsh)
source /opt/homebrew/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh
zstyle ':fzf-tab:*' query-string '' # for carapace
zstyle ':fzf-tab:*' use-fzf-default-opts yes # reuse ~/.config/fzf/config
zstyle ':fzf-tab:*' switch-group '<' '>' # cycle completion groups
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -1 --color=always $realpath' # for zoxide

# mise
eval "$(mise activate zsh)"

# haskell
alias g="ghc"
[ -f ~/.ghcup/env ] && . ~/.ghcup/env
