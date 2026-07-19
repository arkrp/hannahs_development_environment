#!/usr/bin/bash
project_directory=$(realpath $(dirname $BASH_SOURCE))
podman build --jobs 0 -t dev_container $project_directory
podman run \
   --replace \
   -it \
   -p 9345:22 \
   --userns=auto:size=2000 \
   --secret dev_private_key \
   --secret admin_public_key \
   --secret sandbox_public_key \
   --name dev_container \
   dev_container $1
#--pod test_service_pod \
