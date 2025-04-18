#!/bin/bash

# sudo mkfs.xfs -O ^has_journal,^metadata_csum /dev/pmem1
# sudo mkfs.ext4 -O ^has_journal,^metadata_csum /dev/pmem0

sudo mkfs.ext4 /dev/pmem0
sudo mkfs.xfs -f /dev/pmem1

dev0="pmem0"
dev1="pmem1"
home=$(pwd)

mount_dir="${home}/pm"
mount_dir_other="${home}/pm_other"

if [ ! -d "$home/pm" ]
then
    mkdir pm
fi

if [ ! -d "$home/pm_other" ]
then
    mkdir pm_other 
fi

is_mount=$(mount | grep -w "${dev0}")
if [ ! "$is_mount" ]
then
    sudo mount -o dax,noatime,nodiratime /dev/${dev0} ${mount_dir_other}
    sudo chown -R $USER:$USER ${mount_dir_other}
fi

is_mount=$(mount | grep -w "${dev1}")
# mount
if [ ! "$is_mount" ]
then
    sudo mount -o dax,noatime,nodiratime /dev/${dev1} ${mount_dir}
    sudo chown -R $USER:$USER ${mount_dir}
fi