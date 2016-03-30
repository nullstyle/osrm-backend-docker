#!/bin/bash
set -e
DATA_PATH=${DATA_PATH:="/osrm-data"}

_sig() {
  kill -TERM $child 2>/dev/null
}

if [ "$1" = 'osrm' ]; then
  trap _sig SIGKILL SIGTERM SIGHUP SIGINT EXIT

  DATA_PATH=$2
  echo "disk=$DATA_PATH/snapshot.stxxl,250000,syscall" > ./.stxxl

  ./osrm-extract $DATA_PATH/snapshot.osm.pbf
  ./osrm-contract $DATA_PATH/snapshot.osrm
else
  exec "$@"
fi
