#!/bin/bash -e

if [ -z ${1} ]; then
  echo usage: $0 port
  exit 1
fi

port=$1

# [<rulename>],tcp|udp,[<hostip>], <hostport>,[<guestip>],<guestport> |
VBoxManage controlvm "docker-vm" natpf1 "127.0.0.1tcp${port},tcp,127.0.0.1,${port},,${port}"
