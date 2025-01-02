# Client side installation and mount (uncomment and edit server-ip as needed)
sudo apt install -y nfs-common

sudo mount server-ip:/mnt/shared_nfs /mnt

df -h

echo 'Client has been setup successfully.'
