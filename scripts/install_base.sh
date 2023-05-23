#! /bin/bash

USER_HOME=$(eval echo ~${SUDO_USER})
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DOCKER_COMPOSE_VERSION="1.25.0"

echo "------- Installing Common Deps ----------"
# Update
apt install -y build-essential curl apt-transport-https ca-certificates gnupg-agent software-properties-common xclip

# Get docker key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add

apt update -y

# Clean out any old docker installs
apt-get remove -y docker docker-engine docker.io containerd runc
apt autoremove -y

echo "--------- Adding repositories ----------"

add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "-------- Installing ---------"

apt install -y konsole wget grep zsh docker-ce docker-ce-cli containerd.io

echo "------------- Installing Docker Compose ---------------"

curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "------------- Update default terminal --------------"

sudo update-alternatives --config x-terminal-emulator

echo "------------- Add your current user to the docker group manually --------------"

echo "sudo usermod -aG docker $(who | awk '{print $1}')"

echo "once complete, close this terminal and open a new one"
