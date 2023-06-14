#!/bin/bash
set -euo pipefail

pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
    peertube-runner unregister --url "${PEERTUBE_RUNNER_URL}"
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

# setup handlers
# on callback, kill the last background process, which is `tail -f /dev/null` and execute the specified handler
trap 'kill ${!}; term_handler' SIGINT
trap 'kill ${!}; term_handler' SIGTERM

# run application
peertube-runner server &
pid="$!"

if [[ -z "${PEERTUBE_RUNNER_NAME}" ]]; then
  PEERTUBE_RUNNER_NAME=$(hostname)
fi

peertube-runner register --url "${PEERTUBE_RUNNER_URL}" --registration-token "${PEERTUBE_RUNNER_REGISTRATION_TOKEN}" --runner-name "${PEERTUBE_RUNNER_NAME}"

# wait forever
while true
do
  tail -f /dev/null & wait ${!}
done

