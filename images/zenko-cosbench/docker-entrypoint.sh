#!/bin/bash

# set -e stops the execution of a script if a command or pipeline has an error
set -e

# modifying controller.conf
# DRIVERS var can accept comma separated values
if [[ "$DRIVERS" ]]; then
    IFS="," read -ra HOST_NAMES <<< "$DRIVERS"
    counter=0
    for host in "${HOST_NAMES[@]}"; do
	crudini --set controller.conf driver${counter} name ${host}
	crudini --set controller.conf driver${counter} url http://${host}:18088/driver
	counter=$((counter+1))
    done
    crudini --set controller.conf controller drivers ${#HOST_NAMES[@]}
    echo "Host name has been modified to ${HOST_NAMES[@]}"
    echo "Note: In your /etc/hosts file on Linux, OS X, or Unix with root permissions, make sure to associate 127.0.0.1 with ${HOST_NAMES[@]}"
fi

if [[ "$LOG_LEVEL" ]]; then
    if [[ "$LOG_LEVEL" == "TRACE" || "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INFO" || "$LOG_LEVEL" == "WARN" || "$LOG_LEVEL" == "ERROR" ]]; then
	crudini --set controller.conf controller log_level ${LOG_LEVEL}
	crudini --set driver.conf controller log_level ${LOG_LEVEL}
        echo "Log level has been modified to $LOG_LEVEL"
    else
        echo "The log level you provided is incorrect (TRACE/DEBUG/INFO/WARN/ERROR)"
    fi
fi

exec "$@"
