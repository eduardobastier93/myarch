#!/usr/bin/env bash

echo "Formatting storage"
cryptsetup luksFormat -c aes-xts-plain64 -s 512 -h sha512 --use-random -i 100 /dev/sda3
cryptsetup luksOpen /dev/sda3 storage
mkfs.ext4 /dev/mapper/storage

cryptsetup luksOpen /dev/sda3 storage
dd if=/dev/urandom of=/root/keyfile bs=1024 count=4
chmod 0400 /root/keyfile
cryptsetup -v luksAddKey /dev/sda3 /root/keyfile

UUID=$(blkid /dev/sda3 | awk -F '"' '{print $2}')
crypttab="storage UUID=$UUID /root/keyfile luks"
echo "" >> /etc/crypttab
echo $crypttab >> /etc/crypttab

echo "" >> /etc/fstab
echo "/dev/mapper/storage  /media/storage     ext4    defaults        0       2"
