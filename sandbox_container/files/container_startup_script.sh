#!/bin/bash
echo "loading ssh keys"
mkdir /home/sandbox/.ssh
cp -R /run/secrets/dev_key.pub /home/sandbox/.ssh/authorized_keys
chown -R sandbox:sandbox /home/sandbox/.ssh
chmod 644 /home/sandbox/.ssh/authorized_keys
echo "activating sshd"
chmod 0755 /var/run/sshd
/usr/sbin/sshd -D
