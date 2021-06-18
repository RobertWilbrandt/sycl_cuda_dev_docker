#!/bin/bash
set -e

# Start openssh server
/usr/sbin/sshd

exec "$@"
