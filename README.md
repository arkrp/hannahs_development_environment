hannahs_development_environment
Hannah Nelson 2026

This development environment is designed to replace my previous custom development environment; dev-container-base.

The big change is that there are now two conainers for secure seperation.
    dev:
        contains the editing equiptment and ssh keys for publishing to git
    sandbox:
        container to operate ai, and test untrusted applications.

This container currently does not have all features of the previous iteration. These will be copied in as needed.

TODO:
make the "sandbox" command to jump to the sandbox environment
