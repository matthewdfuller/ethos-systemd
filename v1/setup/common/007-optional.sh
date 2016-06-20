#!/usr/bin/bash -x

echo "-------Follower node, beginning optional setup scripts-------"
for service in $(etcd-get /environment/services)
do
  servicedir=${SCRIPTDIR}/${VERSION}/opt/${service}/setup/common
  if [[ ! -d $servicedir ]]; then
      continue
  fi

  for script in $(ls $servicedir|grep -e '.sh$')
  do
      sudo $servicedir/${script}
  done
done
echo "-------Follower node, done optional setup scripts-------"
