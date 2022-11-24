#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Install Base programs
sudo ./install_base.sh

# Install asdf and languages
zsh ./install_env.sh

# Setup configs
mkdir -p ${HOME}/.config/nvim
cp ${SCRIPT_DIR}/../configs/nvim/* ${HOME}/.config/

# Install Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Run"
echo "TSInstall javascript"
echo "TSInstall go"
echo "CocInstall coc-go"
