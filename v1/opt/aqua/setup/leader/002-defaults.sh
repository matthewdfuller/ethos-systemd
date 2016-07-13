#!/usr/bin/bash -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../../../../lib/helpers.sh
source /etc/environment

etcd-set /aqua/config/db-path "${POSTGRES_DB_PATH::-5}"
etcd-set /aqua/config/db-name "$POSTGRES_DB_NAME"
etcd-set /aqua-audit/config/db-path "${POSTGRES_AUDIT_DB_PATH::-5}"
etcd-set /aqua-audit/config/db-name "$POSTGRES_AUDIT_DB_NAME"
etcd-set /aqua/config/aqua-token "aquatoken"
etcd-set /aqua/config/password "password"
