#!/bin/bash
script_directory=$(realpath $(dirname $BASH_SOURCE))

declare_secret () {
   podman secret rm $1
   podman secret create $1 $script_directory/keys/$1
}

declare_secret "admin_public_key"
declare_secret "dev_private_key"
declare_secret "dev_public_key"
declare_secret "sandbox_private_key"
declare_secret "sandbox_public_key"
