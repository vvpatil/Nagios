################################################################################
## This script will help in scheduling downtime for n number of hosts         ##
## in your large enviournment.                                                ##
## Just enter the list of hostnames as configured in nagios in                ##
## server_list.txt file.                                                      ##
## Plugin by Vishal Vilas Patil  - vishal.patil2906@gmail.com		          ##
################################################################################
!/bin/bash

echo "Enter the Start time of Downtime as below format"
echo "Wed Mar 20 13:49:20 EST 2019"
read from;
fromtime=`date -d "$from" +%s`

echo "Enter the End time of Downtime as below format"
echo "Wed Mar 20 13:49:20 EST 2019"
read to;
totime=`date -d "$to" +%s`

echo "Enter your User ID"
read user;

echo "Enter Comments for downtime"
read comment

while read host
do

`echo -e "[%lu] SCHEDULE_HOST_SVC_DOWNTIME;$host;$fromtime;$totime;1;0;;$user;$comment" > /usr/local/nagios/var/rw/nagios.cmd`

 echo "Downtime Scheduled for $host"
done < server_list.txt