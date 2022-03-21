# Taps
tap 'homebrew/cask'
tap 'homebrew/bundle'
tap 'homebrew/cask-fonts'
tap 'warrensbox/tap'
# For github cli auth https://docs.github.com/en/get-started/getting-started-with-git/caching-your-github-credentials-in-git
tap 'microsoft/git'

# Make sure apps get installed in system Applications dir
cask_args appdir: '/Applications'

# Install GNU core utilities (those that come with OS X are outdated)
# See https://github.com/kubernetes/community/blob/master/contributors/devel/development.md#setting-up-macos
brew 'coreutils'
brew 'ed'
brew 'gawk'
brew 'gnu-sed'
brew 'gnu-tar'
brew 'grep'
brew 'make'

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew 'findutils'

# Install Bash 4
brew 'bash'

# Install Binaries
brew 'awscli'
brew 'git'
brew 'hub'
brew 'tree'
brew 'trash'
brew 'wget'
brew 'pyenv'
brew 'jq'
brew 'yq'
brew 'ripgrep'
brew 'go'
brew 'fzf'
# for code signing
brew 'gnupg'
brew 'pinentry-mac'
## Kubernetes
brew 'kubectx'
brew 'kube-ps1'
## Github Actions
brew 'act'

# Apps
cask 'iterm2'
cask 'rectangle'
cask 'flux'
cask 'raycast'
cask '1password'
cask '1password-cli'
# map right_cmd button to escape
# map capslock button to left_ctrl
cask 'karabiner-elements'
# fonts
cask 'font-meslo-lg-nerd-font'
cask 'font-fira-code'
cask 'git-credential-manager-core'
cask 'mactex'
cask 'tomighty'

## Pai Apps
# VPN client
cask 'pritunl'
# k8s visualization
cask 'lens'
# Pai Binaries
brew 'warrensbox/tap/tfswitch'
brew 'terragrunt'

