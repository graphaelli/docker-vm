#!/bin/bash -e

if [ -z ${1} ]; then
  echo usage: $0 port
  exit 1
fi

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
D=${SCRIPTPATH}/.tunnels
SSH_CONFIG=$D/$1.ssh-config
SSH_CONTROL=$D/.$1-ssh

mkdir -p $D
pushd ${SCRIPTPATH}
vagrant ssh-config > ${SSH_CONFIG}
popd
cat >> ${SSH_CONFIG} <<EOF
  ExitOnForwardFailure yes
  LocalForward $1 127.0.0.1:$1
EOF
echo tunneling $1
ssh -M -N -f -F ${SSH_CONFIG} -S ${SSH_CONTROL} docker-vm
