#! /bin/zsh

ASDF_VERSION="0.10.0"
GOLANG_VERSION="1.19"
NODEJS_VERSION="18.12.0"

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
echo "golang ${GOLANG_VERSION}"

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
asdf install nodejs ${NODEJS_VERSION}
asdf global nodejs ${NODEJS_VERSION}
asdf reshim
npm install -g yarn

echo "---------- Install GO ---------------"

asdf plugin-add golang
asdf install golang ${GOLANG_VERSION}
asdf global golang ${GOLANG_VERSION}

source ${HOME}/${RC_FILE}

echo "Installed asdf $(asdf --version)"
echo "Installed nodejs $(node --version)"
echo "Installed yarn $(yarn --version)"
