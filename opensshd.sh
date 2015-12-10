#!/bin/sh
set -e

USER=$(whoami)
export USER

if ! test -d /data/ssh; then
    mkdir -p /data/ssh
    ssh-keygen -q -f /data/ssh/ssh_host_key -N '' -t rsa1
    ssh-keygen -q -f /data/ssh/ssh_host_rsa_key -N '' -t rsa
    ssh-keygen -q -f /data/ssh/ssh_host_dsa_key -N '' -t dsa
    ssh-keygen -q -f /data/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
    ssh-keygen -q -f /data/ssh/ssh_host_ed25519_key -N '' -t ed25519
    chmod 600 /data/ssh/*
fi

exec /usr/sbin/sshd -Def /app/gogs/openshift/sshd_config
