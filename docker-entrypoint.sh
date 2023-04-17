#!/bin/sh

set -e

USER=user

# Add user and create folders
if [[ -n $UID ]] && [[ $UID != "0" ]]; then
  echo "A UID was given!"
  if ! id user &> /dev/null; then
    echo "User $UID does not exist. Creating..."
    if [[ -n $GID ]] && [[ $GID != "0" ]] && [[ $GID != $UID ]]; then
      adduser --disabled-password --gecos "" --no-create-home --uid "$UID" --ingroup $GID $USER
    else
      adduser --disabled-password --gecos "" --no-create-home --uid "$UID" $USER
    fi
  fi
else
  echo "No UID given..."
  USER=root
fi

echo "Starting portmapper..."
rpcbind -d &
rpc_pid=$!
echo "Starting nfs daemon as $USER - $UID ..."
su $USER -c 'unfsd -d' &
nfsd_pid=$!

wait -n $rpc_pid $nfsd_pid

# Exit with status of process that exited first
exit $?
