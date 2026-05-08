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

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
plugins=(virtualenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv)
#
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/opt/powerlevel10k/share/powerlevel10k/powerlevel10k.zsh-theme
source ~/.p10k.zsh
. "$HOME/.local/bin/env"


# ## ## ######################################################################################################
# proxy helpers
# ## ## ######################################################################################################
_DOTFILES_PROXY_URL="http://192.168.139.3:10808"

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

eval "$(ssh-agent -s)"
_ssh_add_if_present "$HOME/.ssh/adinit"
_ssh_add_if_present "$HOME/.ssh/debian-emulation"
_ssh_add_if_present "$HOME/.ssh/github_st2l"
_ssh_add_if_present "$HOME/.ssh/mws_gitlab"
_ssh_add_if_present "$HOME/.ssh/honor"

# Project-specific settings. Keep them only when the referenced files exist.
if [[ -f "$HOME/Documents/mts/kubeconfig/config" ]]; then
  export KUBECONFIG="$HOME/Documents/mts/kubeconfig/config"
fi

alias s="kitten ssh"

clear
export PATH="$HOME/.local/bin:$PATH"


export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

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

# kubernetes configurations
export KUBECONFIG="$HOME/.kube/compute.yaml"

# bind for jump keys
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# end clear
clear
