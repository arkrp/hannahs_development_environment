#!/usr/bin/bash
project_directory=$(realpath $(dirname $BASH_SOURCE))
podman build --jobs 0 -t sandbox_container $project_directory
podman run \
   --replace \
   -it \
   -p 9345:22 \
   --userns=auto:size=2000\
   --secret dev_public_key \
   --secret sandbox_private_key \
   --name sandbox_container \
   sandbox_container $1
#--pod test_service_pod \
