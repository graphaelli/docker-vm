#!/bin/bash -e

if [ -z ${1} ]; then
  echo usage: $0 port
  exit 1
fi

VBoxManage controlvm "docker-vm" natpf1 delete "127.0.0.1tcp${1}"
