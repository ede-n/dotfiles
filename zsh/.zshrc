# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# For rust cli productivity tools
eval "$($(brew --prefix)/bin/zoxide init zsh)"
# Replace MacOS default BSD binaries with GNU
# GNUBINS_PATH=$(find /opt/homebrew/opt -type d -follow -name gnubin -print | awk '{printf "%s:", $0}')
# export PATH=$GNUBINS_PATH:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin
export PATH="$HOME/.poetry/bin:$PATH"
# For tfswitch
export PATH=$HOME/bin:$PATH
export PATH=$HOME/workspace/peopleai/platform/bin:$PATH

export GPG_TTY=$(tty)

###------oh-my-zsh---------###
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git 
    zsh-syntax-highlighting
	zsh-autosuggestions
    k
    extract
    kubectl
    poetry
)

source $ZSH/oh-my-zsh.sh
###-----oh-my-zsh ends-----###

### Pai env vars used to configure aliases
[[ -f ~/.config/people-ai/envvars ]] && \
  source ~/.config/people-ai/envvars || \
  echo "No envvars file found at ~/.config/people-ai/envvars"
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.zsh_functions_pai ]] && source ~/.zsh_functions_pai

# powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

###----color----###
# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1
###---color ends---###

###--- pyenv --- ###
eval "$(pyenv init -)"

###--- jenv ---###
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

### postgresql
export PATH="/opt/homebrew/opt/postgresql@12/bin:$PATH"

### Rust is manually installed
export PATH="$HOME/.cargo/bin:$PATH"
source "$HOME/.cargo/env"

### Antlr
export CLASSPATH=".:${HOME}/.local/bin/antlr4.jar:$CLASSPATH"

### Nvm
# source $(brew --prefix nvm)/nvm.sh
PATH="$(xcode-select -p)/usr/bin:$PATH"
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"

### Krew was installed manually
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
