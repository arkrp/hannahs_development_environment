#!/bin/bash
echo "loading ssh keys"
mkdir /home/dev/.ssh
cp -R /run/secrets/dev_key.pub /home/dev/.ssh/authorized_keys
chown -R dev:dev /home/dev/.ssh
chmod 644 /home/dev/.ssh/authorized_keys
cp /run/secrets/sandbox_host_key /etc/ssh/host_key
chmod 600 /etc/ssh/host_key
echo "activating sshd"
chmod 0755 /var/run/sshd
/usr/sbin/sshd -D
