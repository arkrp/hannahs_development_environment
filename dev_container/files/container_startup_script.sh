#!/bin/bash
echo "loading ssh keys"
#section-start load dev account keys
mkdir /home/dev/.ssh
cp /run/secrets/admin_key.pub /home/dev/.ssh/authorized_keys
cp /run/secrets/dev_key /home/dev/.ssh/id_rsa
chown -R dev:dev /home/dev/.ssh
chmod 644 /home/dev/.ssh/authorized_keys
chmod 600 /home/dev/.ssh/id_rsa
#section-end
cp /run/secrets/dev_host_key /etc/ssh/host_key
chmod 600 /etc/ssh/host_key
echo "activating sshd"
chmod 755 /var/run/sshd
/usr/sbin/sshd -D
