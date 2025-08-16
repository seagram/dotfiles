# aliases
# use '\' before command to ignore alias
alias ls='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first'
alias lsl='eza --color=always --long --no-filesize --no-time --no-user --no-permissions --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first'
alias tree='eza --tree --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first --git-ignore'
alias sz="source ~/.zshrc"
alias c="clear"
alias e="exit"
alias t="tmux"
alias v="nvim"
alias vim="nvim"
alias lv="vim -c \"normal '0\""
alias lg="lazygit"
alias sql="lazysql"
alias g="gemini --yolo --checkpointing"
alias man="tldr"
alias top="btop"
alias cat="bat -p"
alias yt-dlp="/Users/callumairlie/.yt-dlp"
alias yt-audio='yt-dlp -f ba -x --audio-format aac'
alias yt-video="yt-dlp -f 'bv*[height<=1080]+ba/b[height<=1080]' --recode-video mp4"
alias fabric='fabric-ai'

# exports
export VISUAL="nvim"
export EDITOR="nvim"
export TERM="tmux-256color"
export BROWSER="open -a Safari"
export CLICOLOR=YES
export AWS_PROFILE="default"

# options
setopt vi
setopt auto_menu menu_complete
setopt autocd
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
zstyle ':completion:*' menu select # tab opens cmp menu
zstyle ':completion:*' special-dirs true # force . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
zstyle ':completion:*' squeeze-slashes false # explicit disable to allow /*/ expansion

# zsh history setup
HISTSIZE=200
SAVEHIST=200
HISTFILE=$HOME/.zhistory
HISTDUP=erase
HISTCONTROL=ignoreboth
setopt appendhistory inc_append_history sharehistory 
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]='none'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=02'

# homebrew
export HOMEBREW_NO_ENV_HINTS=TRUE
export HOMEBREW_CASK_OPTS=--no-quarantine
export HOMEBREW_NO_UPDATE_REPORT_FORMULAE=TRUE
export HOMEBREW_NO_UPDATE_REPORT_CASKS=TRUE
alias bu="brew upgrade"
alias ba="brew autoremove -v && brew cleanup -s --prune=all -v"
alias bb="brew bundle --file=~/.config/brew/Brewfile --force cleanup"
alias bt="brew deps --tree --installed"
alias bf="brew bundle dump --file=~/.dotfiles/.config/brew/Brewfile --force"

# go
export PATH=$(go env GOPATH)/bin:$PATH

# zoxide
alias cd="z"
eval "$(zoxide init zsh)"

# fnm
eval "$(fnm env --use-on-cd --shell zsh)"

# pnpm
export PNPM_HOME="/Users/callumairlie/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# uv
export PATH="~/.local/bin:$PATH"

# starship.rs
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# terraform
autoload -Uz compinit
compinit
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# fzf
source <(fzf --zsh)
alias f='nvim $(fzf --style minimal --height 40% --layout reverse --border --preview "bat --color=always --style=numbers --line-range=:500 {}")'
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#262626
  --color=hl:#CBE0F0,hl+:#5fd7ff,info:#CBE0F0,marker:#90a6ba
  --color=prompt:#B4D0E9,spinner:#B4D0E9,pointer:#90a6ba,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --preview-window="border-rounded" --prompt="> " --marker=">" --pointer="◆"
  --separator="─" --scrollbar="│" --layout="reverse" --info="right"'

# eza
export EZA_CONFIG_DIR="~/.config/eza/"

# keys
source ~/.keys

# ai
export OPENCODE_CONFIG=~/ai/opencode/opencode.json
alias oc='opencode'
if [[ -d ~/ai/scripts ]]; then
    for script in ~/ai/scripts/*.sh; do
        if [[ -f "$script" ]]; then
            alias_name=$(basename "$script" .sh)
            alias "$alias_name"="$script"
        fi
    done
fi
