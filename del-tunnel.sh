#!/bin/bash -e

if [ -z ${1} ]; then
  echo usage: $0 port
  exit 1
fi

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
D=${SCRIPTPATH}/.tunnels
SSH_CONTROL=$D/.$1-ssh

ssh -S ${SSH_CONTROL} -O exit foo
