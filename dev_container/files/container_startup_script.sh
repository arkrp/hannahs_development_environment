#!/bin/bash
echo "loading ssh keys"
#section-start load dev account keys
mkdir /home/dev/.ssh
cp -R /run/secrets/admin_key.pub /home/dev/.ssh/authorized_keys
cp -R /run/secrets/dev_key /home/dev/.ssh/id_rsa
chown -R dev:dev /home/dev/.ssh
chmod 644 /home/dev/.ssh/authorized_keys
chmod 600 /home/dev/.ssh/id_rsa
#section-end
echo "activating sshd"
chmod 0755 /var/run/sshd
/usr/sbin/sshd -D
