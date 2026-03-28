# Powerlevel10k instant prompt. Keep this close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

emulate -L zsh

# Locale.
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Paths.
typeset -U path
path=(
  "$HOME/.local/bin"
  "$HOME/bin"
  /usr/local/bin
  /usr/local/sbin
  /opt/homebrew/bin
  /opt/homebrew/sbin
  $path
)
export PATH

if command -v go >/dev/null 2>&1; then
  local_go_bin="$(go env GOPATH 2>/dev/null)/bin"
  [[ -n "$local_go_bin" ]] && path+=("$local_go_bin")
  export PATH
fi

# History.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS SHARE_HISTORY APPEND_HISTORY

# Completion and navigation defaults without oh-my-zsh dependency.
autoload -Uz compinit bashcompinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
setopt AUTO_CD INTERACTIVE_COMMENTS

# Prompt.
if [[ -r "$HOME/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true
  source "$HOME/powerlevel10k/powerlevel10k.zsh-theme"
fi
[[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# Small shell niceties that you previously got from plugins.
autoload -Uz colors && colors
setopt PROMPT_SUBST

# Aliases.
alias k="kubectl"

# Proxy helpers.
_DOTFILES_PROXY_URL="socks5://192.168.139.3:12334"

proxy() {
  export http_proxy="$_DOTFILES_PROXY_URL"
  export https_proxy="$_DOTFILES_PROXY_URL"
  export all_proxy="$_DOTFILES_PROXY_URL"
  export HTTP_PROXY="$_DOTFILES_PROXY_URL"
  export HTTPS_PROXY="$_DOTFILES_PROXY_URL"
  export ALL_PROXY="$_DOTFILES_PROXY_URL"
  echo "Proxy mode enabled -> $_DOTFILES_PROXY_URL"
}

noproxy() {
  unset http_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY ALL_PROXY NO_PROXY no_proxy
  echo "Proxy mode disabled"
}

noproxy >/dev/null

export VIRTUAL_ENV_DISABLE_PROMPT=0

maslo() {
  local prompt_file="$HOME/dotfiles/data/maslo.txt"
  local profile="maslo"

  [[ -f "$prompt_file" ]] || {
    echo "No prompt file: $prompt_file" >&2
    return 1
  }

  { cat "$prompt_file"; echo; printf "%s\n" "$*"; } | codex exec -p "$profile" --skip-git-repo-check -
}

_ssh_add_if_present() {
  local key_path="$1"

  [[ -S "$SSH_AUTH_SOCK" ]] || return 0
  [[ -f "$key_path" ]] || return 0
  ssh-add "$key_path" >/dev/null 2>&1
}

_ssh_add_if_present "$HOME/.ssh/adinit"
_ssh_add_if_present "$HOME/.ssh/debian-emulation"
_ssh_add_if_present "$HOME/.ssh/github_st2l"
_ssh_add_if_present "$HOME/.ssh/mws_gitlab"
_ssh_add_if_present "$HOME/.ssh/honor"

# Project-specific settings. Keep them only when the referenced files exist.
if [[ -f "$HOME/Documents/mts/kubeconfig/config" ]]; then
  export KUBECONFIG="$HOME/Documents/mts/kubeconfig/config"
fi

if [[ "$OSTYPE" == darwin* ]] && command -v tmux >/dev/null 2>&1 && [[ -x "$HOME/Documents/mts/multipassport-darwin-arm64" ]]; then
  alias vpnng='tmux new-session -d -s vpnng '\''env -u http_proxy -u https_proxy -u HTTP_PROXY -u HTTPS_PROXY -u ALL_PROXY -u all_proxy -u NO_PROXY -u no_proxy sudo "$HOME/Documents/mts/multipassport-darwin-arm64" connect'\'' && tmux attach -t vpnng'
fi

if [[ "$OSTYPE" == darwin* ]] && command -v tmux >/dev/null 2>&1 && [[ -x "/Applications/Hiddify.app/Contents/MacOS/Hiddify" ]]; then
  alias hidd='tmux new-session -d -s hidd "sudo /Applications/Hiddify.app/Contents/MacOS/Hiddify" && tmux attach -t hidd'
else
  alias hidd='tmux new-session -d -s hidd "sudo hiddify"'
fi

# hacking tools
alias rustscan='docker run -it --rm --name rustscan rustscan/rustscan:2.1.1'
