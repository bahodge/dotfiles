#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Literally nuke everything important
rm -rf ${HOME}/.config/nvim
rm -rf ${HOME}/.local/share/konsole
rm ${HOME}/.zshrc
