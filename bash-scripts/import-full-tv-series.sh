#!/bin/bash
# 
# Should be run together with ./run.sh like following exampler
#  
#  find '/media/pi/sudheera_wd/downloaded/tv/House M.D.' -name '*.mkv' | xargs -d "\n" -L 1 ./run.sh
#

TORRENT_PATH=$TR_TORRENT_DIR/$TR_TORRENT_NAME

echo "Creating kodi dir for $TORRENT_PATH"
TMP=/tmp/transmission-kodi-temp
rm -rf $TMP
mkdir -p $TMP

SHOW_DIR=$(/home/pi/python-scripts/parse-tv-show-dir-name.py "$TR_TORRENT_NAME")	
echo "Show dir name : $SHOW_DIR"
SHOW_PATH="/media/pi/sudheera_wd/tv/$SHOW_DIR"
echo "Show path : $SHOW_PATH"
if [ ! -d "$SHOW_PATH" ]; then
	mkdir "$SHOW_PATH"
fi
SEASON_DIR=$(/home/pi/python-scripts/parse-tv-season-dir-name.py "$TR_TORRENT_NAME")
echo "Season dir name : $SEASON_DIR"
SEASON_PATH="$SHOW_PATH/$SEASON_DIR"
echo "Season path : $SEASON_PATH"
if [ ! -d "$SEASON_PATH" ]; then
	mkdir "$SEASON_PATH"
fi
EPISODE_DIR=$(/home/pi/python-scripts/parse-tv-episode-dir-name.py "$TR_TORRENT_NAME")
echo "Episode name : $EPISODE_DIR"

TARGET_DIR="$TMP/$EPISODE_DIR"
echo "Target dir : $TARGET_DIR"
mkdir "$TARGET_DIR"

if [[ -d "$TORRENT_PATH" ]]; then
	ln -s "$TORRENT_PATH"/* "$TARGET_DIR/"
elif [[ -f "$TORRENT_PATH" ]]; then
	ln -s "$TORRENT_PATH" "$TARGET_DIR/$TR_TORRENT_NAME"
fi
mv "$TARGET_DIR" "$SEASON_PATH"

