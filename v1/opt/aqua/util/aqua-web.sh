#!/usr/bin/bash -x

source /etc/environment

# Wait for gateway to become active
# GW_ACTIVE=$(fleetctl list-units | grep aqua-gateway.service | grep active)
GW_ACTIVE=$(curl -s $AQUA_INTERNAL_ELB:3622)

while [[ "$?" != "0" ]]; do
	echo "Waiting for Aqua gateway to become active..."
  sleep 5;
	GW_ACTIVE=$(curl -s $AQUA_INTERNAL_ELB:3622)
done

IMAGE=$(etcdctl get /images/scalock-server)
SCALOCK_ADMIN_PASSWORD=$(etcdctl get /aqua/config/password)
DB_PASSWORD=$(etcdctl get /environment/RDSPASSWORD)
DB_USERNAME=$(etcdctl get /flight-director/config/db-username)
SCALOCK_DB_NAME=$(etcdctl get /aqua/config/db-name)
SCALOCK_DB_ENDPOINT=$(etcdctl get /aqua/config/db-path)
SCALOCK_GATEWAY_ENDPOINT=$(etcdctl get /aqua/config/gateway-host)
SCALOCK_AUDIT_DB_NAME=$(etcdctl get /aqua/config/db-audit-name)
SCALOCK_TOKEN=$(etcdctl get /aqua/config/aqua-token)

/usr/bin/sh -c "sudo docker run -d -p 8083:8080 \
   --name aqua-web --user=root \
   -e SCALOCK_DBUSER=$DB_USERNAME  \
   -e SCALOCK_DBPASSWORD=$DB_PASSWORD \
   -e SCALOCK_DBNAME=$SCALOCK_DB_NAME \
   -e SCALOCK_DBHOST=$SCALOCK_DB_ENDPOINT \
   -e SCALOCK_SSH_IP_PORT=\"$SCALOCK_GATEWAY_ENDPOINT:3622\" \
   -e SCALOCK_AUDIT_DBUSER=$DB_USERNAME \
   -e SCALOCK_AUDIT_DBPASSWORD=$DB_PASSWORD \
   -e SCALOCK_AUDIT_DBNAME=$SCALOCK_AUDIT_DB_NAME \
   -e SCALOCK_AUDIT_DBHOST=$SCALOCK_DB_ENDPOINT \
   -e SCALOCK_KERNEL_MODE_ENABLED=false \
   -e ADMIN_PASSWORD=$SCALOCK_ADMIN_PASSWORD \
   -e BATCH_INSTALL_TOKEN=\"$SCALOCK_TOKEN\" \
   -e BATCH_INSTALL_NAME=Local-Agents \
   -e BATCH_INSTALL_GATEWAY=$SCALOCK_GATEWAY_ENDPOINT \
   -e BATCH_INSTALL_ENFORCE_MODE=y \
   -v /var/run/docker.sock:/var/run/docker.sock \
   $IMAGE"
