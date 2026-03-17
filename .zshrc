# aliases
# use '\' before command to ignore alias
alias ls='eza --color=always --long --no-filesize --no-time --no-user --no-permissions --icons=always --group-directories-first'
alias tree='eza --tree --color=always --icons=always --group-directories-first --git-ignore'
alias sz="exec zsh"
alias c="clear"
alias e="exit"
alias t="tmux"
alias v="nvim"
alias lv="nvim -c \"normal '0\""
alias k="kubectl"
alias dot="cd ~/github/dotfiles/ && stow -t ~/ ."
alias repo='open "$(git remote get-url origin)" || echo "no remote found"'
alias zcc="zig c++"
alias lg="lazygit"
alias ta="terraform apply -auto-approve"
alias td="terraform destroy -auto-approve"

# exports
export VISUAL="nvim"
export EDITOR="nvim"
export BROWSER="open"
export CLICOLOR=YES

# options
setopt vi
bindkey -v '^?' backward-delete-char # fix backspace in vi mode
setopt auto_param_slash
setopt no_case_glob no_case_match
unsetopt prompt_sp
setopt autocd

# keys
source ~/.keys

##### zsh #####

# optimize completion init
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
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

# zsh completion
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

##### tools #####

# homebrew
export HOMEBREW_NO_ENV_HINTS=TRUE
export HOMEBREW_CASK_OPTS=--no-quarantine
alias bu="brew upgrade"
alias ba="brew autoremove -v && brew cleanup -s --prune=all -v"
alias bt='brew deps --tree $(brew leaves)'
alias bf="brew bundle dump --file=~/github/dotfiles/.config/brew/Brewfile --force --brews --casks"

# zoxide
if [ -z "$DISABLE_ZOXIDE" ]; then
    alias cd="z"
    eval "$(zoxide init zsh)"
    fzf-cd-widget() {
        local dir=$(zoxide query -l --no-tilde | fzf --height 40% --reverse)
        if [[ -n "$dir" ]]; then
            __zoxide_z "$dir"
            zle reset-prompt
        fi
    }
    zle -N fzf-cd-widget
    bindkey '^f' fzf-cd-widget
fi

# starship.rs
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# fzf
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND="fd --hidden --exclude .git --ignore-file ~/.config/fd/ignore . ~"
export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top'

# eza
export EZA_CONFIG_DIR=~/.config/eza/

# convert .docx/.doc to .pdf
pdf() {
    local input="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
    local output="${input%.*}.pdf"
    osascript -e "
        tell application \"Pages\"
            activate
            set doc to open POSIX file \"$input\"
            export doc to POSIX file \"$output\" as PDF
            close doc
        end tell
        tell application \"Pages\" to quit
    "
}

##### languages #####

# python
export PATH=~/.local/bin:$PATH
alias python="python3"

# c/c++
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export CC="/opt/homebrew/opt/llvm/bin/clang"
export CXX="$CC++"
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/llvm/include"

# kubernetes
export KUBECONFIG=~/.config/kube/config

# talos
export TALOSCONFIG=~/.config/talos/config
