#! /usr/bin/env bash

[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

export DATA_PATH=${DATA_PATH:="/osrm-data"}
export EXPORT="north-america-latest"
export OSM_FILE="$DATA_PATH/$EXPORT.osm.pbf"
echo "disk=$DATA_PATH/$EXPORT.stxxl,250000,syscall" > $DATA_PATH/.stxxl
curl http://download.geofabrik.de/$EXPORT.osm.pbf > $OUTFILE
docker run -it --rm -v /osrm-data:/osrm-data nullstyle/osrm-produce osrm north-america-latest "http://download.geofabrik.de/north-america-latest.osm.pbf"

export DEBIAN_FRONTEND="noninteractive"

apt-get purge lxc-docker*
apt-get purge docker.io*
apt-get update
apt-get install -y apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-cache policy docker-engine
apt-get install -y docker-engine
service docker start

apt-get install -y build-essential bison
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
gvm install go1.4
gvm use go1.4
gvm install go1.6
gvm use go1.6 --default


curl http://dist.ipfs.io/go-ipfs/v0.3.11/go-ipfs_v0.3.11_linux-amd64.tar.gz > go-ipfs.tar.gz
tar xvfz go-ipfs.tar.gz
mv go-ipfs/ipfs /usr/local/bin/ipfs
