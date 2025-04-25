#! /bin/bash

# global variables
if ps -p $$ | grep -q zsh$; then
    SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    ASDF_TOOL_VERSIONS_FILE="${SCRIPT_DIR}/.tool-versions"
    CURRENT_SHELL="zsh"
    RC_FILE=".zshrc"
else
    SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    ASDF_TOOL_VERSIONS_FILE="${SCRIPT_DIR}/../.tool-versions"
    CURRENT_SHELL="bash"
    RC_FILE=".bashrc"
fi;

echo "CURRENT SHELL ${CURRENT_SHELL} - ${RC_FILE}"

echo "-------- Setting Up Oh My zsh ---------"

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "-------- Setting up rc file ------------"

# Setup base config files
rm -rf ${HOME}/.config/nvim
rm -rf ${HOME}/.config/helix
rm -rf ${HOME}/.config/terminator
rm -f ${HOME}/${RC_FILE}
mkdir -p ${HOME}/.config/nvim
mkdir -p ${HOME}/.config/helix
mkdir -p ${HOME}/.config/terminator
cp -r ${SCRIPT_DIR}/configs/nvim/* ${HOME}/.config/nvim/
cp -r ${SCRIPT_DIR}/configs/helix/* ${HOME}/.config/helix/
cp -r ${SCRIPT_DIR}/configs/terminator/* ${HOME}/.config/terminator/
cp ${SCRIPT_DIR}/configs/${RC_FILE} ${HOME}/${RC_FILE}

echo "----------- Installing apt dependencies ----------"

echo "updating apt: prompting for sudo password"
sudo apt update -y

echo "installing apt dependencies"
sudo apt install -y build-essential curl apt-transport-https ca-certificates gnupg-agent software-properties-common xclip

echo -n "Do you want to install docker? (y/n): "
read answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    echo "----------- Installing docker and docker compose ----------"

    echo "removing all old docker versions"
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

    echo "adding docker's official GPG key"

    sudo apt-get update -y
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    echo "adding apt repository to apt sources"
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update -y

    echo "installing docker and docker compose"
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
else
    echo "skipping docker installation"
fi

echo "----------- Installing asdf ----------------"

ASDF_INSTALL_LOCATION=$(which asdf)

if [ ! -f "${ASDF_INSTALL_LOCATION}" ]; then
   echo "asdf is not installed, installing the latest version"
   ASDF_INSTALL_LOCATION="/usr/bin"

   # Edit the line under this to install a different version of asdf
   ASDF_VERSION="v0.16.7"
   ASDF_BIN_TARBALL="asdf-${ASDF_VERSION}-linux-amd64.tar.gz"
   wget https://github.com/asdf-vm/asdf/releases/download/${ASDF_VERSION}/${ASDF_BIN_TARBALL}

   echo "extracting asdf bin"
   tar -xvf ${ASDF_BIN_TARBALL}

   sudo mv asdf /usr/bin/

   echo "cleaning up tarball"
   rm ${ASDF_BIN_TARBALL}
else
    echo "asdf is already installed"
fi

echo "----------- Configuring asdf ----------------"

ASDF_DATA_DIR="${HOME}/.asdf"
mkdir -p "${ASDF_DATA_DIR}"

EXPORT_ASDF_DATA_DIR="export ASDF_DATA_DIR=${ASDF_DATA_DIR}"
EXPORT_ASDF_SHIMS_PATH="export PATH=${ASDF_DATA_DIR}/shims:\${PATH}"

echo "updating ${RC_FILE} for asdf"
grep -qF -- "# asdf variables" ${HOME}/${RC_FILE} || echo -e "\n# asdf variables" >> "${HOME}/${RC_FILE}"
grep -qF -- "${EXPORT_ASDF_DATA_DIR}" ${HOME}/${RC_FILE} || echo -e "${EXPORT_ASDF_DATA_DIR}" >> "${HOME}/${RC_FILE}"
grep -qF -- "${EXPORT_ASDF_SHIMS_PATH}" ${HOME}/${RC_FILE} || echo -e "${EXPORT_ASDF_SHIMS_PATH}" >> "${HOME}/${RC_FILE}"

source "${HOME}/${RC_FILE}"

echo "installing dependencies"

while read -r name version; do
  echo "installing ${name} @ version: ${version}"
  asdf plugin add ${name}
  asdf install ${name} ${version}
  asdf set -u ${name} ${version}
  echo "installed ${name}@${version}"
done < ${ASDF_TOOL_VERSIONS_FILE}

echo "installing core node dependencies"

npm install -g yarn typescript-language-server

asdf reshim

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

echo "------------------- Sourcing RC File ---------------------"

source ${HOME}/${RC_FILE}

echo "********************* POST INSTALL *********************"

if ! groups | grep -qF docker; then
    echo "adding user to docker group. this will require a system reboot"
    sudo usermod -aG docker ${USER}
fi

echo "----------------------- restart this shell -----------------------"
