# aliases
# use '\' before command to ignore alias
alias ls='eza --color=always --long --no-filesize --no-time --no-user --no-permissions --icons=always --group-directories-first'
alias lsl='eza --color=always --long --total-size --git --no-time --no-user --no-permissions --icons=always --group-directories-first'
alias tree='eza --tree --color=always --icons=always --group-directories-first --git-ignore'
alias sz="source ~/.zshrc"
alias c="clear"
alias e="exit"
alias t="tmux"
alias v="nvim"
alias lv="vim -c \"normal '0\""
alias man="tldr"
alias top="btop"
alias j="just"
alias pdf="soffice --headless --convert-to pdf"
alias k="kubectl"
alias weather="curl wttr.in"
alias dot="cd ~/github/dotfiles/ && stow -t ~/ ."
alias repo='open "$(git remote get-url origin)" || echo "no remote found"'
alias ts="tailscale"
alias kl="kubectl"
alias tl="talosctl"
alias ta="terraform apply --auto-approve"
alias tp="terraform plan"
alias ch='f() { curl -s "cht.sh/rust/$1?T" | bat -l rust; }; f'

# exports
export VISUAL="nvim"
export EDITOR="nvim"
export TERM="tmux-256color"
export BROWSER="open"
export CLICOLOR=YES
export AWS_PROFILE="default"

# options
setopt vi
setopt auto_param_slash
setopt no_case_glob no_case_match
unsetopt prompt_sp

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
HISTSIZE=200
SAVEHIST=200
HISTFILE=$HOME/.zhistory
setopt inc_append_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]='none'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=02'

# zsh completion
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

##### tools #####

# homebrew
export HOMEBREW_NO_ENV_HINTS=TRUE
export HOMEBREW_CASK_OPTS=--no-quarantine
alias bu="brew upgrade"
alias ba="brew autoremove -v && brew cleanup -s --prune=all -v"
alias bt='brew leaves | xargs -n1 brew deps --tree'
alias bf="brew bundle dump --file=~/.dotfiles/.config/brew/Brewfile --force"

# zoxide
alias cd="z"
eval "$(zoxide init zsh)"
fzf-cd-widget() {
    local dir=$(zoxide query -l --no-tilde | fzf --height 40% --reverse)
    if [[ -n "$dir" ]]; then
        zoxide "$dir"
        zle reset-prompt
    fi
}
zle -N fzf-cd-widget
bindkey '^f' fzf-cd-widget

# starship.rs
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# fzf
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git --ignore-file ~/.config/fd/ignore"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# eza
export EZA_CONFIG_DIR="~/.config/eza/"

# nym
source ~/.config/nym/aliases.sh

##### languages #####

# go
# export PATH=$(go env GOPATH)/bin:$PATH

# python
export PATH="~/.local/bin:$PATH"
alias p="python3"
alias python="python3"
alias uvr="uv run"

# rust
alias cn="cargo new"
alias ci="cargo init"
alias ca="cargo add"
alias cb="cargo build"
alias cr="cargo run"
alias ct="cargo test"
alias cc="cargo check"
alias cf="cargo fmt"

# ansible
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# kubernetes
export KUBECONFIG=~/.config/kube/config

# talos
export TALOSCONFIG=~/.config/talos/config

# javascript
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
