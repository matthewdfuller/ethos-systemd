#!/usr/bin/bash

source /etc/environment

IMAGE=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /images/flight-director)

/usr/bin/sh -c "/usr/bin/docker run \
  --name flight-director \
  --net='host' \
  -e LOG_APP_NAME=flight-director \
  -e FD_API_SERVER_PORT=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/api-server-port` \
  -e FD_CHRONOS_MASTER=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/chronos-master` \
  -e FD_DB_DATABASE=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/db-name` \
  -e FD_DB_ENGINE=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/db-engine` \
  -e FD_DB_PASSWORD=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /environment/RDSPASSWORD` \
  -e FD_DB_PATH=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/db-path` \
  -e FD_DB_USERNAME=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/db-username` \
  -e FD_MARATHON_USER=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /marathon/config/username` \
  -e FD_MARATHON_PASSWORD=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /marathon/config/password` \
  -e FD_DEBUG=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/debug` \
  -e FD_DOCKERCFG_LOCATION=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/dockercfg-location` \
  -e FD_EVENT_INTERFACE=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/event-interface` \
  -e FD_EVENT_PORT=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/event-port` \
  -e FD_FIXTURES=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/fixtures` \
  -e FD_KV_SERVER=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/kv-server` \
  -e FD_LOG_LEVEL=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/log-level` \
  -e FD_LOG_LOCATION=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/log-location` \
  -e FD_LOG_MARATHON_API_CALLS=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/log-marathon-api-calls` \
  -e FD_MARATHON_MASTER=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/marathon-master` \
  -e FD_MESOS_MASTER=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/mesos-master` \
  -e AUTHORIZER_TYPE=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/authorizer-type` \
  -e FD_IAMROLE_LABEL=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/iam-role-label` \
  -e FD_AIRLOCK_PUBLIC_KEY=\"`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/airlock-public-key`\" \
  -e FD_MARATHON_MASTER_PROTOCOL=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/marathon-master-protocol` \
  -e FD_MESOS_MASTER_PROTOCOL=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/mesos-master-protocol` \
  -e FD_ALLOW_MARATHON_UNVERIFIED_TLS=`/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/allow-marathon-unverified-tls` \
  $IMAGE"
