#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

Install Base programs
sudo ${SCRIPT_DIR}/install_base.sh

# Install asdf and languages
zsh ${SCRIPT_DIR}/install_env.sh

# Setup configs
mkdir -p ${HOME}/.config/nvim
cp ${SCRIPT_DIR}/../configs/nvim/* ${HOME}/.config/

# Install Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "----------- Installing Plugins ----------"
nvim --headless +PlugInstall +qall

echo "Post install instructions"
echo "open nvim and run the following commands"
echo "CocInstall coc-go"
echo "TSInstall javascript"
echo "TSInstall go"
