#!/bin/bash

cp ./zfs-multi-mount.sh /usr/local/sbin/zfs-multi-mount.sh
chmod 755 /usr/local/sbin/zfs-multi-mount.sh
chown root:root /usr/local/sbin/zfs-multi-mount.sh

cp ./zfs-load-key.service /etc/systemd/system/zfs-load-key.service
chmod 644 /etc/systemd/system/zfs-load-key.service
chown root:root /etc/systemd/system/zfs-load-key.service

# systemctl enable zfs-load-key
