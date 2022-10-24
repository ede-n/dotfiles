#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

echo "Setting up Macbook..."

BASE_DIR="$(cd -- "$(dirname "$0")" >/dev/null 2>&1; pwd -P )"

function install_or_update_omz_component() {
   # Installs or updates Oh-my-zsh plugins, themes, etc.
   local -r component_type_plural="$1" # plugins, themes, etc
   local -r component_name="$2"
   local -r component_github_url="$3"

   ZSH_CUSTOM="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"

   if [[ ! -d "${ZSH_CUSTOM}/${component_type_plural}/${component_name}" ]]; then
      echo "Installing oh-my-zsh ${component_type_plural} ${component_name}..."
      git clone "${component_github_url}" "${ZSH_CUSTOM}/${component_type_plural}/${component_name}"
   else
      echo "Updating oh-my-zsh ${component_type_plural} ${component_name}..."
      pushd "${ZSH_CUSTOM}/${component_type_plural}/${component_name}" > /dev/null 2>&1
      git pull
      popd > /dev/null 2>&1
   fi

   echo ""
}

function install_bash_commons() {
  local TMP_DIR=$(mktemp -d -t bash_commons-XXXXXX)

  git clone https://github.com/gruntwork-io/bash-commons.git $TMP_DIR/bash-commons

  sudo mkdir -p /opt/gruntwork
  sudo chown -R naveenbabuede:staff /opt/gruntwork
  cp -r ${TMP_DIR}/bash-commons/modules/bash-commons/src /opt/gruntwork/bash-commons
  sudo chown -R "naveenbabuede:staff" /opt/gruntwork/bash-commons
  rm -rf ${TMP_DIR}
}

########### Create a local installations directory ###########
export LOCAL_BIN_DIR="${HOME}/.local/bin/"
mkdir -p "$LOCAL_BIN_DIR"

########### Configure Macos #################
echo "Configuring MacOs from ${HOME}/.macos..."
ln -f "${BASE_DIR}/macos/.macos" "${HOME}/.macos"
source "${HOME}/.macos"
echo " "

########### HomeBrew & Packages #################
echo "Installing HomeBrew packages..."
# Check for Homebrew and install
if test ! "$(which brew)"; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew recipes
brew update

# Install all dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle
echo " "

########### Oh-my-zsh #################
# Check for oh-my-zsh and install
if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# If any of the bash scripts rely on bash-commons
# they need to run after this
install_bash_commons

omz_component_type_plugin="plugins"
# The Syntax Highlighting plugin adds beautiful colors to the commands being typed
install_or_update_omz_component $omz_component_type_plugin "zsh-syntax-highlighting" https://github.com/zsh-users/zsh-syntax-highlighting.git
# The AutoSuggestion plugin auto suggests any of the previous commands.
install_or_update_omz_component $omz_component_type_plugin "zsh-autosuggestions" https://github.com/zsh-users/zsh-autosuggestions.git
install_or_update_omz_component $omz_component_type_plugin "k" https://github.com/supercrabtree/k
install_or_update_omz_component "themes" "powerlevel10k" https://github.com/romkatv/powerlevel10k.git

ln -f "${BASE_DIR}/zsh/.p10k.zsh" "${HOME}/.p10k.zsh"
ln -f "${BASE_DIR}/zsh/zsh_functions_pai" "${HOME}/.zsh_functions_pai"
ln -f "${BASE_DIR}/zsh/aliases" "${HOME}/.aliases"
ln -fs "${BASE_DIR}/zsh/.zshrc" "${HOME}/.zshrc" 
ln -fs "${BASE_DIR}/zsh/.zprofile" "${HOME}/.zprofile"
ln -fs "${BASE_DIR}/zsh/.zshenv" "${HOME}/.zshenv"
ln -fs "${BASE_DIR}/vim/.ideavimrc" "${HOME}/.ideavimrc"

############# fzf ###############
"$(brew --prefix)"/opt/fzf/install --all

############# git ###############
ln -fs "${BASE_DIR}/git/.gitconfig" "${HOME}/.gitconfig"

############ python #############
# Depends on `brew install pyenv` and the presence of init scripts in .zshrc and .zprofile
pyenv install --skip-existing 3.9.10
pyenv global 3.9.10

# These should be at the very bottom as they rely on aliases/functions
source "${BASE_DIR}/zsh/zsh_functions_pai"
echo "Login to AWS code artifact repository..."
aws_codeartifact_creds
source "${BASE_DIR}/golang_pkg_install.sh"
source "${BASE_DIR}/pai_install.sh"
source "${BASE_DIR}/post_python_install.sh"
source "${BASE_DIR}/post_antlr_install.sh"
"${BASE_DIR}/post_java_install.py"


