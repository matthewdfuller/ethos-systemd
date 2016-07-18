#!/usr/bin/bash -x

source /etc/environment

# Wait for web ui to be active
# WEB_ACTIVE=$(fleetctl list-units | grep aqua-web.service | grep active)

# while [[ -z $WEB_ACTIVE ]]; do
# 	echo "Waiting for web UI to become active"
# 	WEB_ACTIVE=$(fleetctl list-units | grep aqua-web.service | grep active)
# 	sleep 5;
# done

IMAGE=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /images/scalock-gateway)
DB_PASSWORD=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /environment/RDSPASSWORD)
DB_USERNAME=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /flight-director/config/db-username)
SCALOCK_DB_NAME=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /aqua/config/db-name)
SCALOCK_DB_ENDPOINT=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /aqua/config/db-path)
SCALOCK_AUDIT_DB_NAME=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /aqua/config/db-audit-name)

/usr/bin/sh -c "sudo docker run -d -p 3622:3622 --name aqua-gateway \
  --net=host \
  -e SCALOCK_DBUSER=$DB_USERNAME \
  -e SCALOCK_DBPASSWORD=$DB_PASSWORD \
  -e SCALOCK_DBNAME=$SCALOCK_DB_NAME \
  -e SCALOCK_DBHOST=$SCALOCK_DB_ENDPOINT \
  -e SCALOCK_AUDIT_DBUSER=$DB_USERNAME \
  -e SCALOCK_AUDIT_DBPASSWORD=$DB_PASSWORD \
  -e SCALOCK_AUDIT_DBNAME=$SCALOCK_AUDIT_DB_NAME \
  -e SCALOCK_AUDIT_DBHOST=$SCALOCK_DB_ENDPOINT \
  $IMAGE"
