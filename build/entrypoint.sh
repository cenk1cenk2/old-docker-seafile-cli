#!/bin/bash

set -e
set -u
set -o pipefail

get () {
    NAME="$1"
    JSON="$2"
    # Tries to regex setting name from config. Only works with strings for now
    VALUE=$(echo $JSON | grep -Po '"'"$NAME"'"\s*:\s*.*?[^\\]"+,*' | sed -n -e 's/.*: *"\(.*\)",*/\1/p')
    # Use eval to ensure that nested expressens are executed (config points to environment var)
    eval echo $VALUE
}

setup_lib_sync(){
    if [ ! -d $DATA_DIR ]; then
      echo "Using new data directory: $DATA_DIR"
      mkdir -p $DATA_DIR
    fi
    TOKEN_JSON=$(curl -d "username=$USERNAME" -d "password=$PASSWORD" ${SERVER_URL}/api2/auth-token/ 2> /dev/null)
    TOKEN=$(get token "$TOKEN_JSON")
    LIBS_IN_SYNC=$(seaf-cli list)
    LIBS=(${LIBRARY_ID//:/ })
    for i in "${!LIBS[@]}"
    do
      LIB="${LIBS[i]}"
      LIB_JSON=$(curl -G -H "Authorization: Token $TOKEN" -H 'Accept: application/json; indent=4' ${SERVER_URL}/api2/repos/${LIB}/ 2> /dev/null)
      LIB_NAME=$(get name "$LIB_JSON")
      ## Use lib name or lib id
      #LIB_DIR=${DATA_DIR}/${LIB_NAME}
      LIB_DIR=${DATA_DIR}/${LIB}
      set +e
      LIB_IN_SYNC=$(echo "$LIBS_IN_SYNC" | grep "$LIB")
      set -e
      if [ ${#LIB_IN_SYNC} -eq 0 ]; then
        echo "Syncing $LIB_NAME"
        mkdir -p $LIB_DIR
        seaf-cli sync -l "$LIB" -s "${SERVER_URL}" -d $LIB_DIR -u "$USERNAME" -p "$PASSWORD"
      fi
    done
}

keep_in_foreground() {
  # As there seems to be no way to let Seafile processes run in the foreground we
  # need a foreground process. This has a dual use as a supervisor script because
  # as soon as one process is not running, the command returns an exit code >0
  # leading to a script abortion thanks to "set -e".
  while true
  do
    for SEAFILE_PROC in "ccnet" "seaf-daemon"
    do
      pkill -0 -f "${SEAFILE_PROC}"
      sleep 5
    done
    seaf-cli status
    sleep 60
  done
}

seaf-cli start
setup_lib_sync
keep_in_foreground