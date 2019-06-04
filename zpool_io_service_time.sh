#!/bin/sh

################################################################################
##                                                                            ##
## Usage: zpool_io_service_time.sh <pool name> <warning ms> <critical ms>     ##
##                                                                            ##
## Description: This script will query the volumes used in the specified      ##
##              zpool runs iostat (once) for these volumes over a period      ##
##              of 10 seconds ignore the first iteration (stats since last    ##
##              boot) calculate the maximum milliseconds average service      ##
##              time for these volumes                                        ##
## Plugin by Vishal Vilas Patil  - vicky_vishalpatil@hotmail.com              ##
##                                                                            ##
################################################################################

PATH=/usr/bin:/usr/sbin

POOL=$1
WARNING=$2
CRITICAL=$3

[ "X$POOL" = "X" ] && exit 3
[ "X$WARNING" = "X" ] && exit 3
[ "X$CRITICAL" = "X" ] && exit 3

zpool list -H $POOL > /dev/null
[ $? -ne 0 ] && exit 3

VOLUME_COUNT=`zpool status $POOL | egrep "c[0-9]d[0-9]" | awk '{print $1}' | wc -l | awk '{print $1}'`
VOLUMES=`zpool status $POOL | egrep "c[0-9]d[0-9]" | awk '{printf $1 " "} END {print}'`

MAX_AVERAGE_SERVICE_TIMES=`iostat -xn $VOLUMES 10 2 | tail -$VOLUME_COUNT | awk '{print $8}' | awk 'BEGIN {max = 0} {if ($1>max) max=$1} END {print max}'`

# Handle Nagios Output

if [ $MAX_AVERAGE_SERVICE_TIMES -ge $CRITICAL ]
        then
                echo "CRITICAL - $MAX_AVERAGE_SERVICE_TIMES milliseconds | time=$MAX_AVERAGE_SERVICE_TIMES;"
                exit 2
        elif [ $MAX_AVERAGE_SERVICE_TIMES -ge $WARNING ]
        then
                echo "WARNING - $MAX_AVERAGE_SERVICE_TIMES milliseconds | time=$MAX_AVERAGE_SERVICE_TIMES;"
                exit 1
        else
                echo "OK - Took $MAX_AVERAGE_SERVICE_TIMES milliseconds | time=$MAX_AVERAGE_SERVICE_TIMES;"
                exit 0
        fi
fi