#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Literally nuke everything important
rm -rf ${HOME}/.config/nvim
rm -rf ${HOME}/.config/helix
rm -rf ${HOME}/.local/share/konsole
rm -f ${HOME}/.zshrc
