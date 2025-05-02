#! /bin/bash

# global variables
if ps -p $$ | grep -q zsh$; then
    SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    CURRENT_SHELL="zsh"
    RC_FILE=".zshrc"
else
    SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    CURRENT_SHELL="bash"
    RC_FILE=".bashrc"
fi;

echo "CURRENT SHELL ${CURRENT_SHELL} - ${RC_FILE}"

# Literally nuke everything important
sudo rm -f /usr/bin/asdf
sudo rm -rf ~/.asdf
rm -rf ${HOME}/.config/nvim
rm -rf ${HOME}/.config/helix
rm -rf ${HOME}/.local/share/konsole
rm -f ${HOME}/${RC_FILE}
