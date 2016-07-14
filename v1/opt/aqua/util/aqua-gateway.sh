#!/usr/bin/bash -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../../../lib/helpers.sh
source /etc/environment

etcd-set /aqua/config/gateway-host $COREOS_PRIVATE_IPV4
