#!/bin/bash
################################################
# Script to init setup devops machine - pippin #
################################################

# Update&Upgrade machine
sudo apt update
sudo apt upgrade -y

# Get ansible
echo "Installing Ansible"
sudo apt install ansible -y
sudo apt install sshpass -y

# Get terraform
echo "Installing Terraform"
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install -y terraform

# Get packer
echo "Installing Packer"
sudo apt-get update && sudo apt-get install -y packer

# Get Vault
echo "Installing Vault"
sudo apt update && sudo apt install -y vault

# Get and set Portainer
sudo docker run -d \
    -p 8000:8000 \
    -p 9443:9443 \
    --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /home/admin/docker/portainer/data:/data \
    portainer/portainer-ce:latest

# Get and set Gitlab
sudo docker run -d \
    -p 443:443 \
    -p 80:80 \
    -p 23:22 \
    --name gitlab \
    --restart=always \
    --volume /home/admin/docker/gitlab/data/config:/etc/gitlab \
    --volume /home/admin/docker/gitlab/data/logs:/var/log/gitlab \
    --volume /home/admin/docker/gitlab/data/data:/var/opt/gitlab \
    --shm-size 256m \
    gitlab/gitlab-ce:latest

# Finish installation
sudo apt update
sudo apt upgrade -y

echo "Installation has finished. Rebooting now."
echo "3.."
sleep 1
echo "2.."
sleep 1
echo "1.."
sleep 1
#sudo reboot