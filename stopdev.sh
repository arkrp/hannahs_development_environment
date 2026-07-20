#!/bin/bash
podman container stop sandbox_container
podman container rm sandbox_container
podman container stop dev_container
podman container rm dev_container
