#!/bin/bash
set -e
apt-get install -y parted
parted -a optimal /dev/nvme0n1 mklabel gpt
parted -a optimal /dev/nvme0n1 mkpart primary ext4 0% 100%
mkfs.ext4 -F /dev/nvme0n1
mkdir -p /osrm-data
mount /dev/nvme0n1 /osrm-data -t ext4

cat << EOF > /etc/apt/sources.list
deb http://192.80.8.135/cblr/links/debian_8-x86_64 jessie main
deb [arch=amd64] http://security.debian.org jessie/updates main non-free contrib
deb [arch=amd64] http://httpredir.debian.org/debian jessie-backports main
deb [arch=amd64] http://httpredir.debian.org/debian jessie main non-free contrib
deb [arch=amd64] http://httpredir.debian.org/debian jessie-updates main non-free contrib
EOF
