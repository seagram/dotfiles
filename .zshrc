# aliases
# use '\' before command to ignore alias
alias ls='eza --color=always --long --no-filesize --no-time --no-user --no-permissions --icons=always --group-directories-first'
alias tree='eza --tree --color=always --icons=always --group-directories-first --git-ignore'
alias sz="source ~/.zshrc"
alias c="clear"
alias e="exit"
alias t="tmux"
alias v="nvim"
alias vim="nvim"
alias lv="vim -c \"normal '0\""
alias man="tldr"
alias top="btop"
alias j="just"
alias pdf="soffice --headless --convert-to pdf"
alias python="python3"
alias py="pypy3"

# exports
export VISUAL="nvim"
export EDITOR="nvim"
export TERM="tmux-256color"
export BROWSER="open -a Safari"
export CLICOLOR=YES
export AWS_PROFILE="default"
export HOMEBREW_NO_UPDATE_REPORT_FORMULAE=1
export HOMEBREW_NO_UPDATE_REPORT_CASKS=1

# options
setopt vi
setopt auto_param_slash
setopt no_case_glob no_case_match
unsetopt prompt_sp

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

# homebrew
export HOMEBREW_NO_ENV_HINTS=TRUE
export HOMEBREW_CASK_OPTS=--no-quarantine
alias bu="brew upgrade"
alias ba="brew autoremove -v && brew cleanup -s --prune=all -v"
alias bt='brew leaves | xargs -n1 brew deps --tree'
alias bf="brew bundle dump --file=~/.dotfiles/.config/brew/Brewfile --force"

# go
export PATH=$(go env GOPATH)/bin:$PATH

# zoxide
alias cd="z"
eval "$(zoxide init zsh)"

# uv
export PATH="~/.local/bin:$PATH"

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

# keys
source ~/.keys

alias ai='f=$(find ~/ai/prompts -type f -exec basename {} \; | fzf --height=50%) && cat ~/ai/prompts/"$f" ~/ai/format/short.md | pbcopy'

# completion
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)
