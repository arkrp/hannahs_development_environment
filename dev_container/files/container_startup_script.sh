#!/bin/bash
echo "loading ssh keys"
#section-start specify host key
cp -R /run/secrets/dev_host_key /etc/ssh/dev_host_key
chmod 600 /etc/ssh/dev_host_key
#section-end
#section-start load dev account keys
mkdir /home/dev/.ssh
cp -R /run/secrets/admin_key.pub /home/dev/.ssh/authorized_keys
cp -R /run/secrets/dev_key /home/dev/.ssh/id_rsa
chown -R dev:dev /home/dev/.ssh
chmod 644 /home/dev/.ssh/authorized_keys
chmod 600 /home/dev/.ssh/id_rsa
#section-end
#section-start load sandbox account keys
mkdir /home/sandbox/.ssh
cp -R /run/secrets/sandbox_key.pub /home/sandbox/.ssh/authorized_keys
chown -R sandbox:sandbox /home/sandbox/.ssh
chmod 644 /home/sandbox/.ssh/authorized_keys
#section-end
echo "activating sshd"
chmod 0755 /var/run/sshd
/usr/sbin/sshd -D
