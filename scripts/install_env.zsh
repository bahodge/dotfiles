#! /bin/zsh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ASDF_VERSION="0.10.2"
GOLANG_VERSION="1.19"
NODEJS_VERSION="18.12.0"
KUBECTL_VERSION="1.23.10"
HELM_VERSION="3.7.2"
SKAFFOLD_VERSION="1.39.4"
RC_FILE=".zshrc"
NEOVIM_VERSION="0.8.2"
RIPGREP_VERSION="13.0.0"
FZF_VERSION="0.35.1"

echo "-------- Setting up rc file ------------"

cp ${SCRIPT_DIR}/${RC_FILE} ${HOME}/${RC_FILE}
source ${HOME}/${RC_FILE}

echo "----------- Installing asdf ----------------"

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v${ASDF_VERSION}
# If this line does not exist in the the rc file, then append it
grep -qF -- "$HOME/.asdf/asdf.sh" "$HOME/$RC_FILE" || echo "\n# asdf\n. $HOME/.asdf/asdf.sh" >> "$HOME/$RC_FILE"
source ${HOME}/${RC_FILE}

echo "---------- Updating asdf ----------------"

asdf update

echo "------------------- Installing Neovim -------------------"

asdf plugin-add neovim
asdf install neovim ${NEOVIM_VERSION}
asdf global neovim ${NEOVIM_VERSION}

echo "------------------- Installing Ripgrep -------------------"

asdf plugin-add ripgrep
asdf install ripgrep ${RIPGREP_VERSION}
asdf global ripgrep ${RIPGREP_VERSION}

echo "------------------- Installing FZF -------------------"

asdf plugin-add fzf
asdf install fzf ${FZF_VERSION}
asdf global fzf ${FZF_VERSION}


echo "---------- Installing nodejs ---------------"

asdf plugin-add nodejs
asdf install nodejs ${NODEJS_VERSION}
asdf global nodejs ${NODEJS_VERSION}
asdf reshim

echo "---------- Installing GO ---------------"

asdf plugin-add golang
asdf install golang ${GOLANG_VERSION}
asdf global golang ${GOLANG_VERSION}

echo "------------------- Installing Kubectl -------------------"

asdf plugin-add kubectl
asdf install kubectl ${KUBECTL_VERSION}
asdf global kubectl ${KUBECTL_VERSION}

echo "------------------- Installing Helm -------------------"

asdf plugin-add helm
asdf install helm ${HELM_VERSION}
asdf global helm ${HELM_VERSION}

echo "------------------- Installing Skaffold -------------------"

asdf plugin-add skaffold
asdf install skaffold ${SKAFFOLD_VERSION}
asdf global skaffold ${SKAFFOLD_VERSION}

source ${HOME}/${RC_FILE}

echo "--------- Installing Deps ----------"

go install golang.org/x/tools/gopls@latest
npm install -g yarn typescript-language-server

echo "--------- Tidying rc file ------"

cat >>${HOME}/${RC_FILE} <<EOL
# Shell Utils
[[ $(which kubectl) ]] && source <(kubectl completion zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Aliases
alias vi="nvim"
alias k="kubectl"
alias lg="lazygit"

# Editor
export EDITOR=/usr/bin/nvim
EOL

# I'm doing this out of band of EOL to control the readability of the path var
echo '# Path' >> ${HOME}/${RC_FILE}
echo -e 'export GOPATH="$(go env GOPATH)"' >> ${HOME}/${RC_FILE}
echo -e 'export PATH="${PATH}:${GOPATH}/bin"' >> ${HOME}/${RC_FILE}
echo -e 'export PATH="${PATH}"' >> ${HOME}/${RC_FILE}

source ${HOME}/${RC_FILE}

# Install any dependencies for nvim
echo "---------- PackerSync -----------"
nvim -c PackerSync -c 'sleep 10' -c qa --headless

echo "Installed asdf $(asdf --version)"
echo "Installed neovim $(nvim --version)"
echo "Installed ripgrep $(rg --version)"
echo "Installed fzf $(fzf --version)"
echo "Installed nodejs $(node --version)"
echo "Installed yarn $(yarn --version)"
echo "Installed go $(go version)"
echo "Installed kubectl $(kubectl version --client --short)"
echo "Installed helm $(helm version)"
echo "Installed skaffold $(skaffold version)"
