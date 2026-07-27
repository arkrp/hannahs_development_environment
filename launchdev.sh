#!/bin/bash
echo "Hello World!"
ACCESS_PORT=9000 # The port which the user should use to ssh into the dev contianer.
project_directory=$(realpath $(dirname $BASH_SOURCE))
#section-start build containers if needed
echo "building images"
set -e
podman build --jobs 0 -t sandbox_container $project_directory/sandbox_container
podman build --jobs 0 -t dev_container $project_directory/dev_container
set +e
echo "done building images"
#section-end
#section-start make sure dev_network exists
echo "initializing dev_network"
podman network create dev_network
echo "done initializing dev_network"
#section-end
#section-start launch containers
echo "launching containers"
podman run \
   -d \
   --network bridge \
   -v workspace:/home/dev/workspace \
   -v sandbox_pi_config:/home/dev/.pi \
   --userns=auto:size=2000 \
   --secret dev_key.pub \
   --secret sandbox_host_key \
   --name sandbox_container \
   --hostname sandbox \
   sandbox_container
podman run \
   -d \
   -p $ACCESS_PORT:22 \
   -v dev_ssh_directory:/home/dev/.ssh \
   --network bridge \
   --device /dev/fuse \
   --cap-add SYS_ADMIN \
   --userns=auto:size=2000 \
   --secret dev_key \
   --secret admin_key.pub \
   --secret dev_host_key \
   --hostname dev \
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
ssh -p 9000 -X -t dev@127.0.0.1
echo "Serpent Praise"
