#!/bin/bash -x

source /etc/environment

# Source the etcd
if [ -f /etc/profile.d/etcdctl.sh ]; then
  source /etc/profile.d/etcdctl.sh;
fi

ROLE_NAME="$(etcdctl -u $ETCDCTL_READ_USER:$ETCDCTL_READ_PASSWORD get /klam-ssh/config/role-name)"
ENCRYPTION_ID="$(etcdctl -u $ETCDCTL_READ_USER:$ETCDCTL_READ_PASSWORD get /klam-ssh/config/encryption-id)"
ENCRYPTION_KEY="$(etcdctl -u $ETCDCTL_READ_USER:$ETCDCTL_READ_PASSWORD get /klam-ssh/config/encryption-key)"
KEY_LOCATION_PREFIX="$(etcdctl -u $ETCDCTL_READ_USER:$ETCDCTL_READ_PASSWORD get /klam-ssh/config/key-location-prefix)"
IMAGE="$(etcdctl -u $ETCDCTL_READ_USER:$ETCDCTL_READ_PASSWORD get /images/klam-ssh)"

echo "Running authorizedkeys_command for $1" | systemd-cat -p info -t klam-ssh

docker run --net=host --rm -e ROLE_NAME=${ROLE_NAME} -e ENCRYPTION_ID=${ENCRYPTION_ID} -e ENCRYPTION_KEY=${ENCRYPTION_KEY} -e KEY_LOCATION_PREFIX=${KEY_LOCATION_PREFIX} ${IMAGE} /usr/lib/klam/getKeys.py $1
exit 0
