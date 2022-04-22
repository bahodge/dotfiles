#! /bin/bash



echo "This script will install the following programs"
echo "neovim"

echo "Continue [y/n]:";
read PROCEED

if [ "$PROCEED" != "y" ] && [ "$PROCEED" != "Y" ];
then
    echo "Exiting"
    exit 0
fi;

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CONFIG_ROOT_DIR="$(cd $SCRIPT_DIR && cd .. && pwd)/configs"
CONFIG_NVIM_ROOT="$HOME/.config/nvim"

echo "----------- Making & Cleaning Config Files ---------"

rm -rf "$CONFIG_NVIM_ROOT"
mkdir -p "$CONFIG_NVIM_ROOT"

echo "----------- Linking Configs --------------"

ln $CONFIG_ROOT_DIR/nvim/* $CONFIG_NVIM_ROOT

echo "----------- Symlinked Nvim --------------"


if [[ $OSTYPE == "darwin"* ]]; then
  echo "The Operating system is darwin"

  echo "---------- Updating Homebrew ---------"
  brew update

  echo "---------- Installing Neovim ---------"
  brew install neovim

  echo "---------- Aliasing Vim -> NeoVim ----"

  
fi;

if [[ $OSTYPE == "linux"* ]]; then
  echo "The Operating system is linux"

  
  if [ "$EUID" -ne 0 ]
    then echo "🔒 Yikes! Please run this script as root! 🔒"
    exit
  fi

  echo "----------- Updating apt ----------"
  apt update -y

  echo "----------- Installing neovim ----------"
  apt install neovim

  echo "----------- Cleaning up ----------"
  apt autoremove -y
fi;


echo "----------- Installing Plug -------------"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "------------ Installing Plugins -----------"

vim +PluginInstall +qall
