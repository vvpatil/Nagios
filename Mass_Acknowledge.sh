################################################################################
## This script will help in acknowldge host alerts for n number of hosts      ##
## in your large enviournment.                                                ##
## Just enter the list of hostnames as configured in nagios in                ##
## server_list.txt file.                                                      ##
## Plugin by Vishal Vilas Patil  - vishal.patil2906@gmail.com		          ##
################################################################################
#!/bin/bash

while read line
do

`echo -e "[%lu] ACKNOWLEDGE_HOST_PROBLEM;$line;2;1;0;vishal;Ack testing" > /usr/local/nagios/var/rw/nagios.cmd`

  echo "$line Done"
done < server_list