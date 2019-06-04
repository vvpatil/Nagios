# Nagios
Plugins/scripts/documents for Nagios/Zpool_io_service_time.sh

Usage: zpool_io_service_time.sh <pool name> <warning ms> <critical ms>

Description: This script will query the volumes used in the specified zpool runs iostat (once) for these volumes over a period of 10 seconds ignore the first iteration (stats since last boot) calculate the maximum milliseconds average service time for these volumes.
