#!/bin/bash
echo "Shutting down development environment"
podman container stop -t 5 sandbox_container dev_container
podman container rm sandbox_container dev_container
podman network rm dev_network
echo "Shutdown complete"
