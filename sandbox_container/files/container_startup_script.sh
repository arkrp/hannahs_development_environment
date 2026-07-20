#!/bin/bash
echo "loading ssh keys"
mkdir /home/sandbox/.ssh
cp -R /run/secrets/dev_key.pub /home/sandbox/.ssh/authorized_keys
cp -R /run/secrets/sandbox_key /home/sandbox/.ssh/id_rsa
echo "dev" $(cat /run/secrets/dev_host_key.pub ) > /home/sandbox/.ssh/known_hosts
chown -R sandbox:sandbox /home/sandbox/.ssh
chmod 644 /home/sandbox/.ssh/known_hosts
chmod 644 /home/sandbox/.ssh/authorized_keys
chmod 600 /home/sandbox/.ssh/id_rsa
echo "activating sshd"
chmod 0755 /var/run/sshd
/usr/sbin/sshd -D
