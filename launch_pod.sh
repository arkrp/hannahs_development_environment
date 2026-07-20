#!/bin/bash
access_port=9000 # The port which the user should use to ssh into the dev contianer.
project_directory=$(realpath $(dirname $BASH_SOURCE))
#section-start build containers if needed
podman build --jobs 0 -t sandbox_container $project_directory/sandbox_container
podman build --jobs 0 -t dev_container $project_directory/dev_container
#section-end
#section-start make sure dev_network exists
echo "initializing dev_network"
podman network exists dev_network
if [[ $? == 1 ]]; then
   echo "dev_network not found. creating network"
   podman network create dev_network
else
   echo "dev_network exists. Proceeding."
fi
#section-end
podman run \
   --replace \
   -d \
   -p 9345:22 \
   --network bridge \
   --userns=auto:size=2000 \
   --secret dev_public_key \
   --secret sandbox_private_key \
   --name sandbox_container \
   sandbox_container $1
podman network connect --alias sandbox dev_network sandbox_container
