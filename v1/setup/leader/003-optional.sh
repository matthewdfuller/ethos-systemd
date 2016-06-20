#!/usr/bin/bash -x

echo "-------Leader node, beginning optional setup scripts-------"
for service in $(etcd-get /environment/services)
do
  servicedir=${SCRIPTDIR}/${VERSION}/opt/${service}/setup/leader
  if [[ ! -d $servicedir ]]; then
      continue
  fi

  for script in $(ls $servicedir|grep -e '.sh$')
  do
      sudo $servicedir/${script}
  done
done
echo "-------Leader node, done optional setup scripts-------"
