# Replace MacOS default BSD binaries with GNU
GNUBINS_PATH=$(find /opt/homebrew/opt -type d -follow -name gnubin -print | awk '{printf "%s:", $0}')
export PATH=$GNUBINS_PATH:$PATH

###------oh-my-zsh---------###
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

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
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
###-----oh-my-zsh-----###



