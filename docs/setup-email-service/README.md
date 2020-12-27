# Sending emails with `msmtp`

## Install `msmtp` using `apt`

```shell script
sudo apt update
sudo apt install msmtp ca-certificates
```

## Configure with you user data

1. Create a user config file at : `~/.msmtprc` with following config

    ```
    account default
    host smtp.gmail.com
    from <your-user-id>@gmail.com
    auth on
    port 587
    user <your-user-id>@gmail.com
    password <your-password>
    logfile ~/.msmtp.log
    tls on
    tls_starttls on
    tls_trust_file /etc/ssl/certs/ca-certificates.crt
    ```

2. Give necessary permissions

```shell script
chmod 600 ~/.msmtprc
```

# Test sending an email

```shell script
echo -e "Subject: Test Subject\r\n\r\nThis is a test" | msmtp --from=default -t recipient@gmail.com
```
