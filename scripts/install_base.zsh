#! /bin/bash

USER_HOME=$(eval echo ~${SUDO_USER})
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DOCKER_COMPOSE_VERSION="1.25.0"

echo "------- Installing Common Deps ----------"
# Update
apt install -y curl apt-transport-https ca-certificates gnupg-agent software-properties-common

# Get docker key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add

apt update -y

# Clean out any old docker installs
apt-get remove -y docker docker-engine docker.io containerd runc
apt autoremove -y

echo "--------- Adding repositories ----------"

add-apt-repository -y ppa:gnome-terminator
add-apt-repository -y ppa:neovim-ppa/stable
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "-------- Installing ---------"

apt install -y wget fzf ripgrep terminator neovim zsh docker-ce docker-ce-cli containerd.io
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "------------- Adding user to docker group ---------------"

usermod -aG docker $USER

echo "------------- Installing Docker Compose ---------------"

curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "close this terminal and open a new one"
