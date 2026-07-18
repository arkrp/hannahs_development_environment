#!/bin/bash
echo "loading ssh keys"
mkdir /home/ai_agent/.ssh
cp -R /run/secrets/ai_execution_sandbox_authorized_keys /home/ai_agent/.ssh/authorized_keys
cp -R /run/secrets/ai_execution_sandbox_ssh_private_key /home/ai_agent/.ssh/id_rsa
chown -R ai_agent:ai_agent /home/ai_agent/.ssh
echo "activating sshd"
chmod 0755 /var/run/sshd
/usr/sbin/sshd -D
