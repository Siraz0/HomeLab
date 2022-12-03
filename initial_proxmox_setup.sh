#!/bin/bash
proxmox_init () {
    echo "============== PROXMOX setup ======================"
    echo "Settings sources list..."
    #rm -rf "/etc/apt/sources.list"
    echo "deb http://ftp.debian.org/debian bullseye main contrib
deb http://ftp.debian.org/debian bullseye-updates main contrib
# security updates
deb http://security.debian.org/debian-security bullseye-security main contrib
# PVE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription" > /etc/apt/sources.list
    echo "Done."
    echo "Commenting out pve-enterprise..."
    echo "# deb https://enterprise.proxmox.com/debian/pve buster pve-enterprise" > /etc/apt/sources.list.d/pve-enterprise.list
    echo "Done."
    echo "Running update&dist-upgrade"
    apt-get update -y
    apt dist-upgrade -y
    echo "Done."
    echo "-----------------------------------------------------------"
    echo "|             Proxmox init setup done !                   |"
    echo "-----------------------------------------------------------"
    echo "Rebooting machine in"
    echo "3..."
    sleep 1
    echo "2..."
    sleep 1
    echo "1..."
    sleep 1
    echo "CYA!"
    reboot
}

create_devops_vm () {
    echo "============== VM setup ================="
    echo "Downloading ubuntu-20.04-server iso..."
    wget -P /var/lib/vz/template/iso "https://releases.ubuntu.com/20.04.5/ubuntu-20.04.5-live-server-amd64.iso"
    echo "Download complete."
    echo "Downloading packer..."
    apt-get install packer -y
    echo "Downloading git..."
    apt-get install git -y
    echo "Download complete."
}

echo "-----------------------------------------------------------"
echo "| Welcome to the initial Proxmox configuratator by Sirazo |"
echo "-----------------------------------------------------------"
echo ""
echo "Select one of the following options:"
echo "----------"
echo "[1] Proxmox initial setup with setting DevOps Virtual Machine."
echo ""
echo "[2] Proxmox initial setup only."
echo "----------"
echo ""
read -p "Option: " option
case $option in
    1)
    #Proxmox init setup with devops VM
    create_devops_vm
    proxmox_init
    ;;
    2)
    #Only proxmox init setup
    proxmox_init
    ;;
    *)
    echo "Please choose 1 or 2. Exitting.."
    ;;
esac