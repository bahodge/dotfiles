#! /bin/bash

USER_HOME=$(eval echo ~${SUDO_USER})
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "The following script will install the following:";
echo "interwebs: curl & wget"
echo "shell: zsh & ohmyzsh"
echo "terminal: gnome-terminator"
echo "editor: neovim"
echo "a whole bunch of aliases"

echo "Continue [y/n]:";
read PROCEED

if [ "$PROCEED" != "y" ] && [ "$PROCEED" != "Y" ];
then
    echo "Exiting"
    exit 0
fi;

echo "------- Prep ----------"

# Repositories
add-apt-repository ppa:gnome-terminator ppa:neovim-ppa/stable -y

# Update
apt update -y
apt autoremove -y

echo "-------- Installing ---------"

apt install -y curl wget fzf ripgrep terminator neovim zsh software-properties-common
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "-------- Setting up rc file ------------"

cp ${SCRIPT_DIR}/.zshrc ${USER_HOME}/.zshrc

echo "close this terminal and open a new one"
