#!/usr/bin/bash -x

source /etc/environment

# Source the etcd
if [ -f /etc/profile.d/etcdctl.sh ]; then
  source /etc/profile.d/etcdctl.sh;
fi

# Handle retrying of all etcd sets and gets
function etcd-set() {
    if [[ "$#" -gt 1 ]]; then
      etcdctl -u $ETCDCTL_WRITE_USER:$ETCDCTL_WRITE_PASSWORD set "$@"
      while [ $? != 0 ]; do sleep 1; etcdctl -u $ETCDCTL_WRITE_USER:$ETCDCTL_WRITE_PASSWORD set $@; done
    fi
}

function etcd-get() {
    etcdctl -u $ETCDCTL_READ_USER:$ETCDCTL_READ_PASSWORD get "$@"
    # "0" and "4" responses were successful, "4" means the key intentionally doesn't exist
    while [[ $? != 0 && $? != 4 ]]; do sleep 1; etcdctl -u $ETCDCTL_READ_USER:$ETCDCTL_READ_PASSWORD get $@; done
}

# Handle retrying of all fleet submits and starts
function submit-fleet-unit() {
    sudo fleetctl submit "$@"
    while [ $? != 0 ]; do sleep 1; sudo fleetctl submit $@; done
}

function start-fleet-unit() {
    sudo fleetctl start "$@"
    while [ $? != 0 ]; do sleep 1; sudo fleetctl start $@; done
}
