#!/usr/bin/bash
project_directory=$(realpath $(dirname $BASH_SOURCE))
podman build --jobs 0 -t secure_execution_sandbox $project_directory
podman run \
   --replace \
   -it \
   -p 9345:22 \
   -v $project_directory/ssh:/app/ssh \
   --name secure_execution_sandbox \
   secure_execution_sandbox $1
#--pod test_service_pod \
