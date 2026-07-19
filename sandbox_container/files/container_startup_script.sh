#!/bin/bash
echo "loading ssh keys"
mkdir /home/sandbox/.ssh
cp -R /run/secrets/dev_public_key /home/sandbox/.ssh/authorized_keys
cp -R /run/secrets/sandbox_private_key /home/sandbox/.ssh/id_rsa
chown -R sandbox:sandbox /home/sandbox/.ssh
echo "activating sshd"
chmod 0755 /var/run/sshd
/usr/sbin/sshd -D
