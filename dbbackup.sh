#!/bin/sh
#Script created by AGHETTI Charly
#01/09/2005
 
filename="/root/backups/savedb_daily"
last=6
i=0
 
################################################
# To know the last file which has been created #
################################################
 
filetemp="$filename.$i.sql"
while test -e "$filetemp" -a "$i" -ne "$last";
do
  i=`expr $i + 1`
  filetemp="$filename.$i.sql"
done
 
#######################################
# Delete the last file if it's the 6e #
#######################################
 
test "$i" -ne "$last";
  rm -rf "$filetemp"
 
##############################
# Increase all name of files #
##############################
 
j=$i
while test "$j" -ne 0;
do
  mv "$filename.`expr $j - 1`.sql" "$filename.$j.sql"
  j=`expr $j - 1`
done
 
###############################
# Execute the pg_dump command #
###############################
 
mysqldump --user=root --password=XXX -A > /root/backups/savedb_daily.0.sql
scp /root/backups/savedb_daily.0.sql XXX@XXX:/home/XXX/backups/
