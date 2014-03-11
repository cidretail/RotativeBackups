#!/bin/sh
#Script created by AGHETTI Charly
#01/09/2005
 
filename="/root/backups/savehome_daily"
last=6
i=0
 
################################################
# To know the last file which has been created #
################################################
 
filetemp="$filename.$i.tar.gz"
while test -e "$filetemp" -a "$i" -ne "$last";
do
  i=`expr $i + 1`
  filetemp="$filename.$i.tar.gz"
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
  mv "$filename.`expr $j - 1`.tar.gz" "$filename.$j.tar.gz"
  j=`expr $j - 1`
done
 
###############################
# Execute the pg_dump command #
###############################
 
tar -czvf /root/backups/savehome_daily.0.tar.gz /home 1>/dev/NULL 2>/dev/NULL
scp /root/backups/savehome_daily.0.tar.gz XXX@XXXX:/home/XXXX/backups/
