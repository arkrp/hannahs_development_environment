#!/bin/bash
echo "starting ssh tunnel hop"
mkdir /home/accessuser/.ssh
cp -R /run/secrets/ai_execution_sandbox_authorized_keys /home/accessuser/.ssh/authorized_keys
cp -R /run/secrets/ai_execution_sandbox_ssh_private_key /home/accessuser/.ssh/ssh_private_key
chown -R accessuser:accessuser /home/accessuser/.ssh
chmod 0755 /var/run/sshd
echo "ssh proxy hop is online"
/usr/sbin/sshd -D
