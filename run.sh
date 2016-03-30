#! /usr/bin/env bash
set -e

[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

export DATA_PATH=${DATA_PATH:="/osrm-data"}
export EXPORT="north-america/us-west-latest"
export DEST_DIR=$DATA_PATH/$EXPORT
export DATA_HOST="http://download.geofabrik.de"

mkdir -p $DEST_DIR
curl $DATA_HOST/$EXPORT.osm.pbf > $DEST_DIR/snapshot.osm.pbf

docker run -it --rm -v /osrm-data:/osrm-data \
  nullstyle/osrm-produce \
  osrm $DEST_DIR

rm $DEST_DIR/snapshot.stxxl
ipfs add -r $DEST_DIR
