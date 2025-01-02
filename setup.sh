#!/bin/bash

# Update package repository
if [ -x "$(command -v apt)" ]; then
    sudo apt update
    sudo apt install -y nfs-kernel-server nfs-common
elif [ -x "$(command -v yum)" ]; then
    sudo yum update -y
    sudo yum install -y nfs-utils
else
    echo "Package manager not supported. Exiting."
    exit 1
fi

# Create shared directory and set permissions
sudo mkdir -p /mnt/shared_nfs
sudo chmod 777 /mnt/shared_nfs

# Configure NFS exports
echo "/mnt/shared_nfs 192.168.1.0/24(rw,sync,no_subtree_check,no_root_squash)" | sudo tee -a /etc/exports

# Export shared directories
sudo exportfs -arv

# Start and enable NFS server on boot
if [ -x "$(command -v systemctl)" ]; then
    sudo systemctl start nfs-server
    sudo systemctl enable nfs-server
else
    sudo service nfs-server start
    sudo chkconfig nfs-server on
fi

# Open NFS ports for a subnet
if [ -x "$(command -v ufw)" ]; then
    sudo ufw allow from 192.168.1.0/24 to any port nfs
elif [ -x "$(command -v firewall-cmd)" ]; then
    sudo firewall-cmd --add-service=nfs --permanent
    sudo firewall-cmd --reload
fi

# Verify NFS exports
sudo exportfs -v

# Client side installation and mount (uncomment and edit server-ip as needed)
# sudo apt install -y nfs-common
# sudo yum install -y nfs-utils
# sudo mount server-ip:/mnt/shared_nfs /mnt
# df -h

echo "NFS server setup is complete. Please uncomment and edit the client-side commands as needed."

