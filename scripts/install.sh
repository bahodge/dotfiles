#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Setup base config files
rm -rf ${HOME}/.config/nvim
mkdir -p ${HOME}/.config/nvim
cp -r ${SCRIPT_DIR}/../configs/nvim/* ${HOME}/.config/nvim/
cp ${SCRIPT_DIR}/../configs/.zshrc ${HOME}/.zshrc

# Install Base programs
sudo ${SCRIPT_DIR}/install_base.sh

# Install asdf and languages
${SCRIPT_DIR}/install_env.sh

