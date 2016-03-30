#!/bin/bash
set -e
export DEBIAN_FRONTEND="noninteractive"

# install docker
curl -sSL https://get.docker.com/ | sh
service docker start
docker pull nullstyle/osrm-produce

# install ipfs
curl http://dist.ipfs.io/go-ipfs/v0.3.11/go-ipfs_v0.3.11_linux-amd64.tar.gz > go-ipfs.tar.gz
tar xvfz go-ipfs.tar.gz
mv go-ipfs/ipfs /usr/local/bin/ipfs

cat << EOF > /lib/systemd/system/ipfs.service

[Unit]
Description=IPFS daemon

[Service]
User=root
ExecStart=/usr/local/bin/ipfs daemon
Restart=on-failure

[Install]
WantedBy=default.target

EOF

mkdir -p /root/.ipfs
ipfs init -f
service ipfs start
