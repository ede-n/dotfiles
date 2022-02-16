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
fi

ln -fs "${BASE_DIR}/zsh/.zshrc" "${HOME}/.zshrc" 
ln -fs "${BASE_DIR}/zsh/.zprofile" "${HOME}/.zprofile"


#ln -fs "${clone_path}/.zshenv" "${HOME}/.zshenv" \
#    && ln -fs "${clone_path}/.config/zsh/.zshrc" "${HOME}/.config/zsh/.zshrc" \
#    && ln -fs "${clone_path}/.config/zsh/.zprofile" "${HOME}/.config/zsh/.zprofile" \
#    && ln -fs "${clone_path}/.config/zsh/.aliases" "${HOME}/.config/zsh/.aliases" \
#    && ln -fs "${clone_path}/.gitconfig" "${HOME}/.gitconfig" 
