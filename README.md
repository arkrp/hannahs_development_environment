hannahs_development_environment
Hannah Nelson 2026

This development environment is designed to replace my previous custom development environment; dev-container-base.

The big change is that there are now two conainers for secure seperation. These containers allow for isolation keys and programs that require them from potentially rogue AI agents/ malicious payloads in develeopment projects. Additionally both containers have user namespace isolation enabled which grants extra security against escapes.
    dev:
        contains the editing equiptment and ssh keys for publishing to git
    sandbox:
        container to operate ai, and test untrusted applications. To enter a terminal into the sandbox simply type "sandbox" then hit enter from bash!

This container currently does not have all features of the previous iteration. These will be copied in as needed.
