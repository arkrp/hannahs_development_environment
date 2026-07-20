#!/bin/bash
echo "Hello World!"
set -e
access_port=9000 # The port which the user should use to ssh into the dev contianer.
project_directory=$(realpath $(dirname $BASH_SOURCE))
#section-start build containers if needed
echo "building images"
podman build --jobs 0 -t sandbox_container $project_directory/sandbox_container
podman build --jobs 0 -t dev_container $project_directory/dev_container
echo "done building images"
#section-end
#section-start make sure dev_network exists
echo "initializing dev_network"
podman network exists dev_network
if [[ $? == 1 ]]; then
   echo "dev_network not found. creating network"
   podman network create dev_network
else
   echo "dev_network exists. proceeding."
fi
echo "done initializing dev_network"
#section-end
#section-start launch containers
echo "launching containers"
podman run \
   -d \
   -p 9345:22 \
   --network bridge \
   --userns=auto:size=2000 \
   --secret dev_key.pub \
   --secret dev_host_key.pub \
   --secret sandbox_key \
   --name sandbox_container \
   --hostname sandbox_container \
   sandbox_container
podman run \
   -d \
   -p 9000:22 \
   -v dev_ssh_directory:/home/dev/.ssh \
   --network bridge \
   --userns=auto:size=2000 \
   --secret dev_key \
   --secret dev_host_key \
   --secret admin_key.pub \
   --secret sandbox_key.pub \
   --hostname dev_container \
   --name dev_container \
   dev_container
echo "done launching containers"
#section-end
#section-start connect containers to network
echo "connecting containers to network"
podman network connect --alias sandbox dev_network sandbox_container
podman network connect --alias dev dev_network dev_container
echo "done connecting containers to network!"
#section-end
echo "Serpent Praise"
