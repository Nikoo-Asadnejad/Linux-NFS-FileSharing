# Client side installation and mount (uncomment and edit server-ip as needed)
if [ -x "$(command -v apt)" ]; then
    sudo apt install -y nfs-common
elif [ -x "$(command -v yum)" ]; then
    sudo yum install -y nfs-utils
else
    echo "Package manager not supported. Exiting."
    exit 1
fi

sudo mount server-ip:/mnt/shared_nfs /mnt

df -h

echo 'Client has been setup successfully.'
