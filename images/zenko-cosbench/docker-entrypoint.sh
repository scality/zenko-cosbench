#!/bin/bash

# set -e stops the execution of a script if a command or pipeline has an error
set -e

# modifying controller.conf
# DRIVERS var can accept comma separated values
if [[ "$DRIVERS" ]]; then
    IFS="," read -ra HOST_NAMES <<< "$DRIVERS"
    counter=1
    for host in "${HOST_NAMES[@]}"; do
	crudini --set conf/controller.conf driver${counter} name ${host}
	crudini --set conf/controller.conf driver${counter} url http://${host}:18088/driver
	counter=$((counter+1))
    done
    crudini --set conf/controller.conf controller drivers ${#HOST_NAMES[@]}
    echo "Drivers have been updated to ${HOST_NAMES[@]}"
fi

if [[ "$LOG_LEVEL" ]]; then
    if [[ "$LOG_LEVEL" == "TRACE" || "$LOG_LEVEL" == "DEBUG" || "$LOG_LEVEL" == "INFO" || "$LOG_LEVEL" == "WARN" || "$LOG_LEVEL" == "ERROR" ]]; then
	crudini --set conf/controller.conf controller log_level ${LOG_LEVEL}
	crudini --set conf/driver.conf driver log_level ${LOG_LEVEL}
        echo "Log level has been modified to $LOG_LEVEL"
    else
        echo "The log level you provided is incorrect (TRACE/DEBUG/INFO/WARN/ERROR)"
    fi
fi

exec "$@"
