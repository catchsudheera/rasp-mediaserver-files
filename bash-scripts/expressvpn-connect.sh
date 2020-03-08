#!/bin/bash

rm /var/log/expressvpn-start/connet.log 
echo "starting" > /var/log/expressvpn-start/connet.log
until service expressvpn status 1>/dev/null
do
  sleep 10
done

date>>/var/log/expressvpn-start/connet.log
until /usr/bin/expressvpn connect 1>>/var/log/expressvpn-start/connet.log
do
  sleep 10
done
