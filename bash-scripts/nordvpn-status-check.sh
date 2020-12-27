#!/bin/bash

#
# Prerequisite :  ../docs/setup-email-service (https://github.com/catchsudheera/rasp-mediaserver-files/tree/master/docs/setup-email-service)
#
# Add this script as a cron that executes every 10 mins

CONFIG_DIR=~/.nordvpn
ALERTED_FILE=$CONFIG_DIR/alerted

function send_email_alert() {
  TIMESTAMP=$(date '+%Y_%m_%d_%H_%M')
  SUBJECT="[ALERT][$TIMESTAMP] MediaBox ExpressVPN connection is down"
  BODY="Your Raspberry Pi MediaBox VPN connection is down. Status response : $1"
  TO="<admin-email>@gmail.com"

  echo -e "Subject: $SUBJECT\r\n\r\n$BODY" | msmtp --from=default -t $TO
}

mkdir -p $CONFIG_DIR

wget --spider --quiet google.com
if [ "$?" != 0 ]; then
  echo "can't reach google..! Reconnecting nordvpn"
  nordvpn disconnect
  nordvpn connect
fi

RES=$(nordvpn status)
IS_CONNECTED=$(echo "$RES" | grep -c "Status: Connected")

if [ "$IS_CONNECTED" -eq 0 ]; then
  echo "$(date) : Not connected. $RES"
  ls $ALERTED_FILE || (send_email_alert "$RES" && touch $ALERTED_FILE)
else
  rm -f $ALERTED_FILE
  echo "$(date) : Connected"
fi
