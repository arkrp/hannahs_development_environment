#!/bin/bash
echo "loading ssh keys"
mkdir /home/dev/.ssh
cp -R /run/secrets/admin_public_key /home/dev/.ssh/authorized_keys
cp -R /run/secrets/dev_private_key /home/dev/.ssh/id_rsa
chown -R dev:dev /home/dev/.ssh
mkdir /home/sandbox/.ssh
cp -R /run/secrets/sandbox_public_key /home/sandbox/.ssh/authorized_keys
chown -R sandbox:sandbox /home/sandbox/.ssh
echo "activating sshd"
chmod 0755 /var/run/sshd
/usr/sbin/sshd -D
