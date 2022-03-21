#!/usr/bin/env bash

source /opt/gruntwork/bash-commons/bootstrap.sh

########## Github CodeSigning ##############
NEDE_GPG_KEY='C147AAAF4D51476A686E6BA8EA7508B46FD37113'

git config --global gpg.program gpg
# This will fail until the GPG keyring is primed.
git config --global user.signingkey ${NEDE_GPG_KEY}
git config --global commit.gpgsign true

########## Python packages ################
python -m pip install --upgrade pip
pip install ec2instanceconnectcli ansible==2.10.7 boto3
pip install databricks-cli

########## Kubernetes #####################

# shellcheck disable=SC2120
function install_kubectl() {
  local -r reinstall="${1:-N}"

  INSTALL_DIR="${LOCAL_BIN_DIR:-${HOME}/.local/bin/}"

  if [[ -f "${INSTALL_DIR}/kubectl" && "${reinstall}" == "N" ]]; then
     echo "kubectl already installed."
     return
  fi

  echo ""
  echo "Installing kubectl..."

  K8S_STABLE_VER=$(curl -L -s https://dl.k8s.io/release/stable.txt)
  K8S_INSTALL_VER="$K8S_STABLE_VER"

  TEMP_DIR=$(mktemp -d -t dotfiles-install-XXXXXXXXXX)

  curl -Ls -o "${TEMP_DIR}/kubectl" "https://dl.k8s.io/release/${K8S_INSTALL_VER}/bin/darwin/arm64/kubectl"
  curl -Ls -o "${TEMP_DIR}/kubectl.sha256" "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl.sha256"
  echo "$(<"${TEMP_DIR}"/kubectl.sha256)  ${TEMP_DIR}/kubectl" | shasum -a 256 --check

  chmod +x "${TEMP_DIR}/kubectl"
  sudo mv "${TEMP_DIR}/kubectl" "${INSTALL_DIR}/kubectl"
  sudo chown root: "${INSTALL_DIR}/kubectl"
}

install_kubectl
