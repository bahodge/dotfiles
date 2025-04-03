#! /bin/zsh
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ASDF_VERSION="0.14.0"
GOLANG_VERSION="1.23.2"
NODEJS_VERSION="20.18.0"
ZIG_VERSION="0.14.0"
KUBECTL_VERSION="1.23.10"
HELM_VERSION="3.7.2"
SKAFFOLD_VERSION="2.2.0"
MINIKUBE_VERSION="1.26.1"
RC_FILE=".zshrc"
NEOVIM_VERSION="0.10.3"
HELIX_VERSION="25.01"
RIPGREP_VERSION="14.1.1"
FZF_VERSION="0.57.0"
LAZYGIT_VERSION="latest"
BAT_VERSION="0.24.0"
FD_VERSION="9.0.0"

echo "-------- Setting Up Oh My zsh ---------"

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "-------- Setting up rc file ------------"

# Setup base config files
rm -rf ${HOME}/.config/nvim
rm -rf ${HOME}/.config/helix
rm -f ${HOME}/${RC_FILE}
mkdir -p ${HOME}/.config/nvim
mkdir -p ${HOME}/.config/helix
mkdir -p ${HOME}/.config/terminator
cp -r ${SCRIPT_DIR}/configs/nvim/* ${HOME}/.config/nvim/
cp -r ${SCRIPT_DIR}/configs/helix/* ${HOME}/.config/helix/
cp -r ${SCRIPT_DIR}/configs/terminator/* ${HOME}/.config/terminator/
cp ${SCRIPT_DIR}/configs/${RC_FILE} ${HOME}/${RC_FILE}

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

echo "------------------- Installing Helix -------------------"

asdf plugin-add helix-editor
asdf install helix-editor ${HELIX_VERSION}
asdf global helix-editor ${HELIX_VERSION}

echo "------------------- Installing Ripgrep -------------------"

asdf plugin-add ripgrep
asdf install ripgrep ${RIPGREP_VERSION}
asdf global ripgrep ${RIPGREP_VERSION}

echo "------------------- Installing bat -------------------"

asdf plugin-add bat
asdf install bat ${BAT_VERSION}
asdf global bat ${BAT_VERSION}

echo "------------------- Installing fd -------------------"

asdf plugin-add fd
asdf install fd ${FD_VERSION}
asdf global fd ${FD_VERSION}

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

echo "---------- Installing ZIG ---------------"

asdf plugin-add zig
asdf install zig ${ZIG_VERSION}
asdf global zig ${ZIG_VERSION}

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

echo "------------------- Installing Minikube -------------------"

asdf plugin-add minikube
asdf install minikube ${MINIKUBE_VERSION}
asdf global minikube ${MINIKUBE_VERSION}

echo "------------------- Installing Lazygit -------------------"

asdf plugin-add lazygit
asdf install lazygit ${LAZYGIT_VERSION}
asdf global lazygit ${LAZYGIT_VERSION}

echo "------------------- Sourcing RC File ---------------------"

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
export EDITOR=$(which nvim)
EOL

# I'm doing this out of band of EOL to control the readability of the path var
echo '# Path' >> ${HOME}/${RC_FILE}
echo -e 'export GOPATH="$(go env GOPATH)"' >> ${HOME}/${RC_FILE}
echo -e 'export PATH="${PATH}:${GOPATH}/bin"' >> ${HOME}/${RC_FILE}
echo -e 'export PATH="${PATH}"' >> ${HOME}/${RC_FILE}

source ${HOME}/${RC_FILE}

echo "Installed asdf $(asdf --version)"
echo "Installed neovim $(nvim --version)"
echo "Installed helix $(hx --version)"
echo "Installed ripgrep $(rg --version)"
echo "Installed fzf $(fzf --version)"
echo "Installed nodejs $(node --version)"
echo "Installed yarn $(yarn --version)"
echo "Installed go $(go version)"
echo "Installed kubectl $(kubectl version --client --short)"
echo "Installed helm $(helm version)"
echo "Installed minikube $(minikube version)"
echo "Installed skaffold $(skaffold version)"
echo "\n"

echo "--------- Post Install -----------------"
echo "--------- Logout or Restart your machine -------"
echo "after logout or restart"

