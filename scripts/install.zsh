#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Setup base config files
mkdir -p ${HOME}/.config/nvim
cp ${SCRIPT_DIR}/../configs/nvim/* ${HOME}/.config/nvim/
cp ${SCRIPT_DIR}/../configs/.zshrc ${HOME}/.zshrc

# Install Base programs
sudo ${SCRIPT_DIR}/install_base.zsh

# Install asdf and languages
zsh ${SCRIPT_DIR}/install_env.zsh

# Install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
