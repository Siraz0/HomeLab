#!/bin/bash
proxmox_init () {
    echo "======================== Proxmox Setup =========================="
    echo "Settings sources list..."
    rm -rf "/etc/apt/sources.list"
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
    echo "----------------------------------------------------------------"
    echo "|                  Proxmox init setup done !                   |"
    echo "----------------------------------------------------------------"
}

create_devops_vm () {
    echo "========================== VM setup ============================="
    echo "============== Downloading ISO and dependencies ================="
    echo "Downloading ubuntu-20.04-server iso..."
    wget -P /var/lib/vz/template/iso "https://releases.ubuntu.com/20.04.5/ubuntu-20.04.5-live-server-amd64.iso"
    echo "Download complete."
    echo "Settings DevOps machine..."
    echo "Please provide VM details:"
    read -p "VM Name: " vm_name
    read -p "VM ID: " vm_id
    read -p "VM Cores: " vm_cores
    read -p "VM Memory: " vm_mem
    qm create $vm_id --cdrom local:iso/ubuntu-20.04.5-live-server-amd64.iso \
  --name $vm_name --ostype l26 \
  --cpu cputype=host --cores $vm_cores \
  --memory $vm_mem  \
  --net0 bridge=vmbr0,virtio \
  --bootdisk scsi0 --scsihw virtio-scsi-pci --scsi0 file=local-lvm:32
    sleep 3
    qm set $vm_id -onboot 1 -agent 1 -autostart 1
    echo "----------------------------------------------------------------"
    echo "|                  VM: $vm_name - created !                    |"
    echo "----------------------------------------------------------------"
}

host_reboot () {
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
    proxmox_init
    create_devops_vm
    host_reboot
    ;;
    2)
    #Only proxmox init setup
    proxmox_init
    host_reboot
    ;;
    *)
    echo "Please choose 1 or 2. Exitting.."
    ;;
esac
