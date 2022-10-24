#!/usr/bin/env bash

INSTALL_DIR="${LOCAL_BIN_DIR:-${HOME}/.local/bin/}"

function install_antlr() {
    if [[ ! -f "${INSTALL_DIR}/antlr" ]]; then
      curl -s -o "${INSTALL_DIR}/antlr4.jar" https://www.antlr.org/download/antlr-4.10.1-complete.jar
    fi
}

install_antlr
