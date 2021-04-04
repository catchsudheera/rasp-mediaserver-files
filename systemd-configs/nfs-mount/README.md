# Systemd service for mount nfs shares

## !! Important - the unit file should be named properly
- name should represent the full local path of the mount directory
- use `systemd-escape <path-to-the-local-dir>` to generate the name with proper escaping
