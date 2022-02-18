#!/usr/bin/env bash

echo "Setting up Macbook..."

BASE_DIR="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Check for Homebrew and install
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ln -fs "${BASE_DIR}/zsh/.zprofile" "${HOME}/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew recipes
brew update

# Install all dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Check for oh-my-zsh and install
if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  # Install zsh-syntax-highlighting: The Syntax Highlighting plugin adds beautiful colors to the commands being typed
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  # Install zsh-autosuggestions: This plugin auto suggests any of the previous commands.
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  # Install k: 
  git clone https://github.com/supercrabtree/k ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/k
  # Install powerlevel-10k: https://github.com/romkatv/powerlevel10k
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
  echo "Updating zsh-syntax-highlighting plugin..."
  pushd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting > /dev/null 2>&1
  git pull
  popd > /dev/null 2>&1
  pushd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions > /dev/null 2>&1
  echo "Updating zsh-autosuggestions plugin..."
  git pull
  popd > /dev/null 2>&1
  echo "Updating k plugin..."
  pushd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/k > /dev/null 2>&1
  git pull
  popd > /dev/null 2>&1
  echo "Updating powerlevel-10k plugin..."
  pushd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k > /dev/null 2>&1
  git pull
  popd > /dev/null 2>&1
fi

ln -f "${BASE_DIR}/zsh/aliases" "${HOME}/.aliases"
ln -fs "${BASE_DIR}/zsh/.zshrc" "${HOME}/.zshrc" 
ln -fs "${BASE_DIR}/zsh/.zprofile" "${HOME}/.zprofile"
ln -fs "${BASE_DIR}/zsh/.zshenv" "${HOME}/.zshenv"

ln -fs "${BASE_DIR}/git/.gitconfig" "${HOME}/.gitconfig"


