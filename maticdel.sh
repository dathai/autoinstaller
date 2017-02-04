#!/bin/bash
#
nowsecs=$( date +%s )

while read account
do
    username=$( echo $account | cut -d: -f1  )
    expiredays=$( echo $account | cut -d: -f2 )
    expiresecs=$(( $expiredays * 86400 ))
    if [ $expiresecs -le $nowsecs ]
    then
        echo "$username has expired deleting"
        userdel -r "$username"
    fi
done < <( cut -d: -f1,8 /etc/shadow | sed /:$/d )