#!/bin/bash
script_directory=$(realpath $(dirname $BASH_SOURCE))

declare_secret () {
   podman secret exists $1
   if [[ $? == 0 ]]; then
      echo "updating secret: $1"
      podman secret rm $1
      podman secret create $1 $script_directory/keys/$1
   else
      echo "creating secret: $1"
      podman secret create $1 $script_directory/keys/$1
   fi
}

declare_secret "admin_key.pub"
declare_secret "dev_key"
declare_secret "dev_key.pub"
declare_secret "sandbox_key"
declare_secret "sandbox_key.pub"
declare_secret "dev_host_key"
declare_secret "dev_host_key.pub"
