#!/bin/sh

display_usage() {
    echo "Usage: [path/to/src_file]  [path/to/dst_folder] [user@host]"
    echo "Example: sudo ./copy_to_multiple_hosts.sh atom32.bin projects/firmware pi@plughub-provisioner"
    }

if [  $# -le 1 ] 
    then 
        display_usage
        exit 1
    fi

srs_path=$1
dst_path=$2
dst_preffix=$3

file_name=${srs_path##*/}
indexes="a" "b" "c" "d" "e"

password='1111'

for index in $indexes; 
  do
    dst=${dst_preffix}-${index}.local:${dst_path}/${file_name}
    echo $dst
    sshpass -p ${password} rsync -av --progress --ignore-existing ${srs_path} $dst
  done
