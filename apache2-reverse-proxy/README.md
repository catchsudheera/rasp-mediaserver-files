# Adding Apache2 reverse proxy virtualhost configuration and letsencrypt

## Install apache
 - Follow this guide and configure default vanilla apache : https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-20-04

## LetsEncrypt configuration
- Follow this : https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-20-04

## Adding reverse proxy
- update the created `/etc/apache2/sites-available/<hostname>.conf`  and `/etc/apache2/sites-available/<hostname>-le-ssl.conf` to add the proxy config in above files
- `sudo systemctl reload apache2`
