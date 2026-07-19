ai_sandbox_container

Hello! Hannah here again!

I want to use an ai agent to help me code my projects! But I also don't want my ai agent to run into a malicious peice of instructions and steal my ssh keys/ other secrets from my computer.

The limits of advancing AI agents are not currently understood. So I desire the security design to treat the AI agent as equivilant to an unsupervised actively malicious human user of high technical skill level, whom will both exhaust obvious avenues of attack, and attempt to use as of yet unknown privelege escalation attacks.

I want a secure way to work on code with an ai agent that may actively turn malicious at any time. Needless to say, this should also be secure whenever possible when the agent is not acting maliciously

The design constraints are as follows:

   (i) Usability (for when productivity is needed)

      (a) Seamlessly work with files:
         The user should have access to the files that the agent is working on.

      (b) Dependency access:
         The user should be able to install dependencies which the ai may need for projects.

      (c) Quick launch:
         The agent should launch with a single command.

      (d) Resume sessions:
         If an agent has persistent memory the sandbox container should preseve that memory.

      (e) Multiple sessions:
         It should be possible to open seperate sessions without extra hassle.

      (f) Easy install:
         The program should be easy to install with a single .sh file.

      (g) invisible to git:
         The program should leave no trace which would be detected by the git source control system.

   (ii) Mundane security constraints (for attacks from outside):

      (a) Don't take orders from strangers:
         The agent's chat/command interface should only be accessible with secure credentials.

      (b) No strangers at the workbench:
         Files which the agent has been granted access should not be accessible by network attackers.

      (c) Don't share my secrets:
         Keys and security codes should never end in vulnerable metadata

   (iii) Hostile security constraints (for when the agent goes rogue):

      (a) Don't let agents touch my things:
         The agent should only be able to access files/directories for which access has been explictly granted.

      (b) Don't let agents get root:
         The agent should have no way to attain root access on the system.

      (c) Don't open my filesystem up to attack:
         The agent should not be able to access any bind mounts to the host os' filesystem.

Features that I will use to meet these requirements:

UID isolation (Podman):
   UID isolation is a security feature of linux which allows a program to be run in a distinct namespace from the system's primary namespace. Essentially this mangles the UID so even if the program elevates itself to the root UID it still has an offset, effectively making it root in the container but not in the real system.
ssh:
   ssh is a secure way to interact with programs on a remote system in a way which may be configured for strong security and access control.
sshfs:
   sshfs is a ssh based program to mount files from a different filesystem over a secure connection. It allows secure, controlled access to files without using dangerous bind mounts, at the cost of minimal overhead.
Secrets (Podman):
   Secrets are a secure way of assigning keys and other sensitive data to containers. This prevents keys from leaking into the metadata.

The agent must run in an isolated user namespace (search term `UID isolation`). This is a linux kernel security feature that has been recorded to prevent several types of privilege escalation attack from gaining root on the host system.

Security risks that are not covered by this project:

   Hacking the network:
      The agent may attack weakenesses in any network it is connected to.
   Feeding you poison:
      The agent may sabotage or place traps in the code it writes.
   Project infection:
      This framework handles one single agent. If one project which it has access to is compromised all projects it has access to are compromised.

This repo was originally copied from arkrp/ssh_tunnel_hop its documetation will remain as it is partially relevant until rewritten.

ssh_tunnel_hop

This podman container is designed to act as a security layer for podman pods by only allowing connection to ports by ssh tunnels. The idea is that by locking port based services behind ssh keys I can give each device access to only the services relevant to them, while also letting others use the device without giving them access to all of those exposed services.

Essentially this container does this thing:

1. Copies ssh config file from /app/ssh on the container to the home of accessuser
1. Launches a ssh server on port 22 of the container

So this is just a container which can be accessed via ssh. This is beneficial because SSH provides connection via tunnels and security via its keys

To use this:

1. ensure that a file named 'ssh' containing an 'authorized_keys' file with the ssh public keys you would like to grant access is mounted to /app/ssh at the launch of the container.

2. ensure that there is some way to access port 22 of this container.

If these are true then the container should be functional for ssh tunneling and may be used to use ssh tunnels to access services in your pods!

To verify that this is running, just attempt to connect to the ssh while using the ssh private key associated with one of the authorized public keys.
