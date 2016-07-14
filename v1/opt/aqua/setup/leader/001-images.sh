#!/usr/bin/bash -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../../../../lib/helpers.sh

etcd-set /images/scalock-gateway    "index.docker.io/behance/scalock-gateway:v1.1.1"
etcd-set /images/scalock-agent      "index.docker.io/behance/scalock-agent:v1"
etcd-set /images/scalock-server     "index.docker.io/behance/scalock-server:v1.1.1"
