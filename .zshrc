alias sz="exec zsh"
alias ls='eza --color=always --classify --oneline --group-directories-first'
alias tree='eza --tree --color=always --classify --group-directories-first --git-ignore'
alias loc='eza --code'
alias c="clear"
alias e="exit"
alias v="nvim"
alias t="nvim ~/.todo"
alias lv=$'nvim -c "normal \'0"'
alias repo="open \$(git remote get-url origin) || echo 'no remote found'"
alias top='TERM=xterm-256color top -o cpu -n 35 -s 2 -stats command,cpu,mem,time,pid,ports,user'
alias l="nnn -C"
alias lg="lazygit"
alias mr="mise run"
alias md="gh markdown-preview"
alias clj="clojure"

export VISUAL="nvim"
export EDITOR="nvim"
export BROWSER="open -a Helium"
export CLICOLOR=YES
export XDG_CONFIG_HOME="$HOME/.config"

setopt vi
bindkey -v '^?' backward-delete-char
setopt auto_param_slash
setopt no_case_glob no_case_match
setopt extended_glob
unsetopt prompt_sp

setopt auto_cd
setopt auto_list
setopt auto_menu
setopt always_to_end

source ~/.env

zmodload zsh/datetime zsh/stat
autoload -Uz compinit
zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if zstat -A zcompdump_mtime +mtime -- "$zcompdump" 2>/dev/null && (( EPOCHSECONDS - zcompdump_mtime[1] < 86400 )); then
    compinit -C -d "$zcompdump"
else
    compinit -d "$zcompdump"
fi

zstyle ':completion:*' list-colors 'ma=0\;33'
zstyle ':completion:*' squeeze-slashes false
zstyle ':completion:*' menu no
zstyle ':completion:*:descriptions' format '[%d]'

HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTFILE=$HOME/.zhistory
setopt share_history
setopt inc_append_history
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

autoload -Uz add-zle-hook-widget
_highlight_command() {
    region_highlight=()
    local cmd="${BUFFER%% *}"
    if [[ -n "$cmd" ]] && type "$cmd" &>/dev/null; then
        region_highlight+=("0 ${#cmd} fg=02")
    fi
}
add-zle-hook-widget line-pre-redraw _highlight_command

fd_roots=($HOME/${^${(M)${(f)"$(<${XDG_CONFIG_HOME:-$HOME/.config}/fd/roots)"}:#[[:space:]]#[^#[:space:]]*}})
export FZF_CTRL_T_COMMAND="fd --type d . ${(@q)fd_roots}"
export FZF_DEFAULT_COMMAND="$FZF_CTRL_T_COMMAND"
unset fd_roots
export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/config
source <(fzf --zsh)

source /opt/homebrew/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh
zstyle ':fzf-tab:*' fzf-flags --info=hidden
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -1 --color=always $realpath'

export HOMEBREW_NO_ENV_HINTS=TRUE
export HOMEBREW_NO_UPDATE_REPORT_NEW=TRUE
export HOMEBREW_CASK_OPTS=--no-quarantine
alias bu="brew update && brew upgrade -y && mise self-update -y && nvim --headless +'lua vim.pack.update(nil, { force = true })' +qa"
alias ba="brew autoremove -v && brew cleanup -s --prune=all -v"
alias bt='brew deps --tree $(brew leaves)'
alias bf="brew bundle dump --file=~/github/dotfiles/.config/brew/Brewfile --force --brews --casks --no-describe"

if [[ "$TERM_PROGRAM" == ghostty ]]; then
  autoload -Uz add-zsh-hook
  typeset -gi _title_fd
  { exec {_title_fd}>/dev/tty } 2>/dev/null || (( _title_fd = 1 ))
  typeset -g _title_dir
  _title_emit() { builtin print -rnu $_title_fd -- $'\e]2;'"${1//[[:cntrl:]]}"$'\a' }
  _title_precmd() { _title_dir=${${(%):-%~}:t}; _title_emit "${_title_dir:-/}" }
  _title_preexec() { _title_emit "$1 · ${_title_dir:-/}" }
  add-zsh-hook precmd _title_precmd
  add-zsh-hook preexec _title_preexec
  _title_precmd
fi

eval "$(zoxide init zsh)"
function cd() {
  if (( $+functions[__zoxide_z] )); then
    __zoxide_z "$@"
  else
    builtin cd -- "$@"
  fi
}

export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

eval "$(mise activate zsh --shims)"
