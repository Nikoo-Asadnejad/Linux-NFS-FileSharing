# Setting Up an NFS Server on Linux

## Step 1: Install NFS Server
Update the package repository and install the NFS server package.

```bash
# Update package repository
sudo apt update         # For Ubuntu/Debian
sudo yum update         # For CentOS/RHEL

# Install NFS server
sudo apt install nfs-kernel-server -y  # For Ubuntu/Debian
sudo yum install nfs-utils -y          # For CentOS/RHEL

# Create shared directory and set permissions
sudo mkdir -p /mnt/shared_nfs
sudo chmod 777 /mnt/shared_nfs   # Adjust permissions as needed

# Configure NFS exports
sudo nano /etc/exports

/mnt/shared_nfs 192.168.1.0/24(rw,sync,no_subtree_check,no_root_squash)

rw: Read/write access.
sync: Write changes synchronously to disk.
no_subtree_check: Disables subtree checking for better performance.
no_root_squash: Allows root access on the client (use with caution).

# Export shared directories
sudo exportfs -arv

# Start NFS server
sudo systemctl start nfs-server          # For Ubuntu/Debian
sudo systemctl start nfs                 # For CentOS/RHEL

# Enable NFS server on boot
sudo systemctl enable nfs-server         # For Ubuntu/Debian
sudo systemctl enable nfs                # For CentOS/RHEL

# Open NFS ports for a subnet
sudo ufw allow from 192.168.1.0/24 to any port nfs    # For Ubuntu with UFW
sudo firewall-cmd --add-service=nfs --permanent       # For CentOS/RHEL
sudo firewall-cmd --reload

# Verify NFS exports
sudo exportfs -v

# Install NFS client package
sudo apt install nfs-common -y      # For Ubuntu/Debian
sudo yum install nfs-utils -y       # For CentOS/RHEL

# Mount the NFS share
sudo mount server-ip:/mnt/shared_nfs /mnt

# Verify the mount
df -h
