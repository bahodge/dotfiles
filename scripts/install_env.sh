#! /bin/bash

ASDF_VERSION=0.10.0

if echo $SHELL | grep -q zsh$
then
  RC_FILE=".zshrc"
else
  RC_FILE=".bashrc"
fi;

echo "This script will install the following programs"
echo "asdf ${ASDF_VERSION}"
echo "nodejs lts"
echo "yarn"

echo "Continue [y/n]:";
read PROCEED

if [ "$PROCEED" != "y" ] && [ "$PROCEED" != "Y" ];
then
    echo "Exiting"
    exit 0
fi;

echo "----------- Install asdf ----------------"

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v${ASDF_VERSION}
# If this line does not exist in the the rc file, then append it
grep -qF -- "$HOME/.asdf/asdf.sh" "$HOME/$RC_FILE" || echo ". $HOME/.asdf/asdf.sh" >> "$HOME/$RC_FILE"
source ${HOME}/${RC_FILE}

echo "---------- Updating asdf ----------------"

asdf update

echo "---------- Install nodejs ---------------"

asdf plugin-add nodejs
asdf install nodejs lts
asdf global nodejs lts
asdf reshim

echo "---------- Install Yarn ---------------"
npm install -g yarn

echo "Installed asdf $(asdf --version)"
echo "Installed nodejs $(node --version)"
echo "Installed yarn $(yarn --version)"
