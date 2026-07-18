#!/usr/bin/bash
project_directory=$(realpath $(dirname $BASH_SOURCE))
podman build --jobs 0 -t secure_execution_sandbox $project_directory
podman secret rm ai_execution_sandbox_authorized_keys
podman secret create ai_execution_sandbox_authorized_keys $project_directory/config/authorized_keys
podman secret rm ai_execution_sandbox_ssh_private_key
podman secret create ai_execution_sandbox_ssh_private_key $project_directory/config/ssh_private_key
podman run \
   --replace \
   -it \
   -p 9345:22 \
   --userns=auto:size=2000\
   --secret ai_execution_sandbox_authorized_keys \
   --secret ai_execution_sandbox_ssh_private_key \
   --name secure_execution_sandbox \
   secure_execution_sandbox $1
#--pod test_service_pod \
