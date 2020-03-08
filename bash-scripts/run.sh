#!/bin/bash

TEMP="$1"
TR_TORRENT_NAME="$(basename "$TEMP")"
NAME="/$TR_TORRENT_NAME"
TR_TORRENT_DIR="${TEMP/$NAME/}"

export "TR_TORRENT_DIR=$TR_TORRENT_DIR"
export "TR_TORRENT_NAME=$TR_TORRENT_NAME"

./import-full-tv-series.sh
