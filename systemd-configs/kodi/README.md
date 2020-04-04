# Setup kodi as a service to run at startup 

## Place unit file
```shell script
sudo cp kodi.service /etc/systemd/system/kodi.service
sudo chmod 644 /etc/systemd/system/kodi.service
```

## Enable and start
```shell script
sudo systemctl enable kodi.service
sudo systemctl start kodi.service
```
