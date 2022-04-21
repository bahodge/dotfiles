#! /bin/bash


if [ "$EUID" -ne 0 ]
  then echo "🔒 Yikes! Please run this script as root! 🔒"
  exit
fi

echo "This script will install the following programs"
echo "neovim"

echo "Continue [y/n]:";
read PROCEED

if [ "$PROCEED" != "y" ] && [ "$PROCEED" != "Y" ];
then
    echo "Exiting"
    exit 0
fi;


if [[ $OSTYPE == "darwin"* ]]; then
  echo "The Operating system is darwin"
fi;

if [[ $OSTYPE == "linux"* ]]; then
  echo "The Operating system is linux"

  echo "----------- Updating apt ----------"
  apt update -y

  echo "----------- Installing neovim ----------"
  apt install neovim

  echo "----------- Cleaning up ----------"
  apt autoremove -y
fi;


