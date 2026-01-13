# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

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


export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

ssh-add ~/.ssh/mws_gitlab
ssh-add ~/.ssh/ubuntu-emulation
ssh-add ~/.ssh/debian-emulation
ssh-add ~/.ssh/github_st2l
ssh-add ~/.ssh/adinit




export KUBECONFIG=/Users/sadolskii/Documents/mts/kubeconfig/config
export JAVA_HOME=$(/usr/libexec/java_home -v 22.0.2)


alias vpnng='tmux new-session -d -s vpnng '\''env -u http_proxy -u https_proxy -u HTTP_PROXY -u HTTPS_PROXY -u ALL_PROXY -u all_proxy -u NO_PROXY -u no_proxy sudo /Users/sadolskii/Documents/mts/multipassport-darwin-arm64 connect'\'' && tmux attach -t vpnng'
alias hidd='tmux new-session -d -s hidd "sudo /Applications/Hiddify.app/Contents/MacOS/Hiddify" && tmux attach -t hidd'
alias k="kubectl"
alias stegoanal="docker run -it --rm -p 127.0.0.1:6901:6901 -v `pwd`:/data dominicbreuker/stego-toolkit /bin/bash"
alias jira-parser="/Users/sadolskii/Documents/mts/jira_parsers/.venv/bin/python /Users/sadolskii/Documents/mts/jira_parsers/main.py"

alias genpyright="python $HOME/dotfiles/zsh/generate_pyright.py"
alias ppright='echo "{ \"venvPath\": \".\", \"venv\": \".venv\" }" >> pyrightconfig.json'
alias pwninit='pwninit --template-path ~/dotfiles/pwninit/template.py --template-bin-name exe'

alias LSBStego="/Users/sadolskii/Documents/ctf/tools/LSB-Steganography/.venv/bin/python /Users/sadolskii/Documents/ctf/tools/LSB-Steganography/LSBSteg.py"

alias burp="cd /Users/sadolskii/Documents/programs/burpsuite && java -jar burploader.jar"
alias k8s-scan="python /Users/sadolskii/Documents/mts/sec-scan-k8s-util/k8s-analyzer.py --config-file /Users/sadolskii/Documents/mts/sec-scan-k8s-util/config.json"
alias k8s-conf="code /Users/sadolskii/Documents/mts/sec-scan-k8s-util/config.json"
alias kube-hunter="/Users/sadolskii/Documents/mts/k8s/kube-hunter/.venv/bin/python3 /Users/sadolskii/Documents/mts/k8s/kube-hunter/kube-hunter.py"
alias rs-dml='/Users/sadolskii/Documents/tools/FTLRustDemangler/target/release/rs-dml'
clear

# proxy helpers
_DOTFILES_PROXY_URL="socks5://127.0.0.1:12334"

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

noproxy

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/sadolskii/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/sadolskii/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/sadolskii/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/sadolskii/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export VIRTUAL_ENV_DISABLE_PROMPT=0
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"


export PATH="/opt/homebrew/bin/":$PATH
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH
export PATH="$PATH:$(go env GOPATH)/bin"
