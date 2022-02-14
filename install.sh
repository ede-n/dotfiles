#!/usr/bin/env bash

echo "Setting up Macbook..."

BASEDIR=$(dirname $0)

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/naveenbabuede/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew recipes
brew update

# Install all dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

