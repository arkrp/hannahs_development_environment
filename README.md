hannahs_development_environment
Hannah Nelson 2026

This development environment is designed to replace my previous custom development environment; dev-container-base.

The big change is that there are now two conainers for secure seperation. These containers allow for isolation keys and programs that require them from potentially rogue AI agents/ malicious payloads in develeopment projects. Additionally both containers have user namespace isolation enabled which grants extra security against escapes.
    dev:
        contains the editing equiptment and ssh keys for publishing to git
    sandbox:
        container to operate ai, and test untrusted applications.

This container currently does not have all features of the previous iteration. These will be copied in as needed.

Convinience custom commands (intended for normal use):
    `readmd <.md document>`
        renders and displays a markdown document with github standard markdown. This is very good for reading documentation!

Internal custom commands (not intended for normal use):
    `sandbox <command>`
        the sandbox command connects to a tty on the sandbox container with the desired command. This is the main way to enter the sandbox.
    `call_sandbox <command>`
        this is similar to the sandbox command but it does not connect the tty. This means it can be used to pipe output over by ssh.
