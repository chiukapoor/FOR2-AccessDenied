#!/bin/bash
#==============================================================================
#
#          FILE:  login-alert
#
#         USAGE: 
#
#   DESCRIPTION: This script is used to send login alert to admin
#
#        AUTHOR:  Team LocalHost
#       VERSION:  1.0
#       CREATED:  23/03/2019 10:12:08 AM IST
#===============================================================================



# Checking if the required curl package is installed or not.
#if [ $(dpkg-query -W -f='${Status}' curl 2>/dev/null | grep -c "ok installed") -eq 0 ];
#then
#    apt-get install curl -y;
#fi

username=$(whoami)
hostname=$(hostname)
timestamp=$(date)

# sender="hostname@example.com"
# recepient="admingroup@example.com"
# subject="Privileged Account logon used"
# message="`env`"
#     echo "$message" | mail -s "$subject" -r "$sender" "$recepient"

# cURL request to append data in GraphQl Hasura
/usr/bin/curl 'https://for2-accessdenied.herokuapp.com/v1alpha1/graphql' \
-H 'Accept-Encoding: gzip, deflate, br' \
-H 'content-type: application/json' \
-H 'Accept: */*' \
-H 'Connection: keep-alive' \
--data-binary '{"query":"mutation {\n  insert_login_details(objects: {hostname: \"'"$hostname"'\", timestamp: \"'"$timestamp"'\", username: \"'"$username"'\"}) {\n    affected_rows\n  }\n}\n","variables":null}' --compressed &> /dev/null

exit 0