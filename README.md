dev_pod
Hannah Nelson 2026

the ai_sandbox_container is basically done from a login perspective. I think I might also just turn it into a sandbox since I don't see why I would need two seperate unpriveleged sandbox levels for a single developer. I'm going to put together the dev_container.

TODO:
configure the ssh so that the sandbox key only has ftp access.
move secrets to top dir

Ok so it works now as an isolated ssh container.
The last major thing I need to get working is sshfs. I need to set up the ssh private key properly so I can test it. I suspect there will be some issues with the fusefs.
