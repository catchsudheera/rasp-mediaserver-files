# Setup expressvpn client auto connect

## Background
After ExpressVPN binary is installed, it automatically installs a service called `expressvpn`. But this `expressvpn`
service doesn't ensure that the vpn client connect automatically to a vpn server. It just starts ExpressVPN Daemon service.

You can check the unit file for this service from here : `/etc/systemd/system/expressvpn.service`
And the service status by using  : `systemctl status expressvpn`

So we are going to create another service called `expressvpn-connect`

## Write the unit file for `expressvpn-connect` service
 
checkout the unit file I composed [`expressvpn-connect.service`](expressvpn-connect.service)

* Using dependency directives[1] in unit files it is configured to have `expressvpn` service as a dependency, so `expressvpn-connect`
    will always starts after `expressvpn`
* Modify `ExecStart` configuration to point to the script to connect. In my case it is the local file path (absolute) to
    [expressvpn-connect.sh](../../bash-scripts/expressvpn-connect.sh)
* Make log dir and give permission
        `sudo mkdir /var/log/expressvpn-start && sudo chown -R pi /var/log/expressvpn-start`
    
    
    Note: Make sure `expressvpn-connect.sh` script is executable. Make it executable using `sudo chmod +x expressvpn-connect.sh` if not

## Install `expressvpn-connect` service

1. Copy the unit file to `/etc/systemd/system` and set permissions

```shell script
sudo cp expressvpn-connect.service /etc/systemd/system/expressvpn-connect.service
sudo chmod 644 /etc/systemd/system/expressvpn-connect.service
```

2. Test the service 

```shell script
sudo systemctl start expressvpn-connect
```

3. Check the status in expressvpn client
```shell script
expressvpn status
```

4. If everything is ok, enable the service to run at system start
```shell script
sudo systemctl enable expressvpn-connect
```

Restart the raspberry pi and see `expressvpn` is connected. For troubleshooting check the log file `/var/log/expressvpn-start/connet.log`
or try executing [expressvpn-connect.sh](../../bash-scripts/expressvpn-connect.sh) script in terminal





## Useful articles
1. https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files
2. https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units
3. https://www.freedesktop.org/software/systemd/man/systemd.service.html

