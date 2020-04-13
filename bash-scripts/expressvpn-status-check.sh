#!/bin/bash

#
# Prerequisite :  ../docs/setup-email-service (https://github.com/catchsudheera/rasp-mediaserver-files/tree/master/docs/setup-email-service)
#
# Add this script as a cron that executes every 10 mins

CONFIG_DIR=~/.expressvpn
ALERTED_FILE=$CONFIG_DIR/alerted

function send_email_alert() {
  SUBJECT="[ALERT] MediaBox ExpressVPN connection is down"
  BODY="Your Raspberry Pi MediaBox VPN connection is down. Status response : $1"
  TO="<admin-email>@gmail.com"

  echo -e "Subject: $SUBJECT\r\n\r\n$BODY" | msmtp --from=default -t $TO
}

mkdir -p $CONFIG_DIR

RES=$(expressvpn status)
IS_CONNECTED=$(echo "$RES" | grep -c "Connected to")

if [ "$IS_CONNECTED" -eq 0 ]; then
  ls $ALERTED_FILE || (send_email_alert "$RES" && touch $ALERTED_FILE)
else
  rm -f $ALERTED_FILE
fi
