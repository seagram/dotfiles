# aliases
# use '\' before command to ignore alias
alias ls='eza --color=always --long --no-filesize --no-time --no-user --no-permissions --icons=always --group-directories-first'
alias lsl='eza --color=always --long --total-size --git --no-time --no-user --no-permissions --icons=always --group-directories-first'
alias tree='eza --tree --color=always --icons=always --group-directories-first --git-ignore'
alias sz="exec zsh"
alias c="clear"
alias e="exit"
alias t="tmux"
alias v="nvim"
alias lv="nvim -c \"normal '0\""
alias man="tldr"
alias top="btop"
alias pdf="soffice --headless --convert-to pdf"
alias k="kubectl"
alias dot="cd ~/github/dotfiles/ && stow -t ~/ ."
alias repo='open "$(git remote get-url origin)" || echo "no remote found"'
alias kl="kubectl"
alias tl="talosctl"
# alias tp="terraform plan"
alias ta="terraform apply --auto-approve"
alias lg="lazygit"
alias tp="open http://localhost:23625 && tinymist preview --partial-rendering true"
alias journal='f="$(date +"%d-%m-%Y").md" && touch "$f" && nvim "$f"'

# exports
export VISUAL="nvim"
export EDITOR="nvim"
export TERM="tmux-256color"
export BROWSER="open"
export CLICOLOR=YES

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
setopt autocd

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
alias bf="brew bundle dump --file=~/github/dotfiles/.config/brew/Brewfile --force --brews --casks"

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

# tealdeer
export TEALDEER_CONFIG_DIR="~/.config/tealdeer"

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

##### languages #####

# python
export PATH="~/.local/bin:$PATH"
alias python="python3"

# rust
alias cn="cargo new"
alias ci="cargo init"
alias ca="cargo add"
alias cb="cargo build"
alias cr="cargo run"
alias ct="cargo test"
alias cc="cargo check"
alias cf="cargo fmt"
alias rbook="rustup doc --book"
alias rdocs="rustup doc --std"
alias bac="bacon run -- -q"

# ansible
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# kubernetes
export KUBECONFIG=~/.config/kube/config

# talos
export TALOSCONFIG=~/.config/talos/config

# docker
export DOCKER_BUILDKIT=1

# nym shell integration
  nym() {
      local aliases_file="$HOME/.config/nym/aliases.sh"
      command nym "$@"
      local exit_code=$?
      if [[ "$1" =~ ^(add|edit|delete)$ ]] && [[ -f "$aliases_file" ]]; then
          source "$aliases_file"
      fi
      return $exit_code
  }
  [ -f ~/.config/nym/aliases.sh ] && source ~/.config/nym/aliases.sh
