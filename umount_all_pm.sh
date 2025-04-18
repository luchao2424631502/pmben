#!/bin/bash

dev0_path="/dev/pmem0"
dev1_path="/dev/pmem1"
dev0_name="pmem0"
dev1_name="pmem1"

umount_func() {
    devname=$1
    is_mount=$(mount | grep -w $devname)
    mount_dir=$(mount | grep -w "$devname" | awk '{print $3}')
    # echo $is_mount
    # echo $mount_dir
    # exit
    if [ "$is_mount" ]
    then
        sudo umount $mount_dir
    fi
}

umount_func "pmem0"
umount_func "pmem1"