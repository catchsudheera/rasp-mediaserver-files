# Docker installation steps

## Buster backport workaround to fix libseccomp2 issue

 - issue : No internet connection to the container, the date setting is wrong
 - https://docs.linuxserver.io/faq#my-host-is-incompatible-with-images-based-on-ubuntu-focal

```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC 648ACFD622F3D138
echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee -a /etc/apt/sources.list.d/buster-backports.list
sudo apt update
sudo apt install -t buster-backports libseccomp2'
```

## Install docker and docker-compose
```bash
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker ${USER}
# exit and log back in
sudo systemctl enable docker

sudo apt-get install libffi-dev libssl-dev
sudo apt install python3-dev
sudo apt-get install -y python3 python3-pip
sudo pip3 install docker-compose
```

## Make .env file in the same level as docker-compose.yml with following content
```
VPN_USERNAME=<email>
VPN_PASSWORD=<pass>
NETWORK=192.168.178.0/24
TRANSMISSION_USERNAME=<username-to-webui>
TRANSMISSION_PASSWORD=<pass>
WHITELIST=127.0.0.1,192.168.*.*
```

## docker compose run
```bash
docker-compose up -d
```

## If the transmission downloads in to a shared mount
 - make docker systemd service depend on the mount systemd service using `After` and `BindsTo` options
 - https://www.freedesktop.org/software/systemd/man/systemd.unit.html

