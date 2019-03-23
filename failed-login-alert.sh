#!/bin/bash
#==============================================================================
#
#          FILE:  failed-login-alert
#
#         USAGE: 
#
#   DESCRIPTION: This script is used to send failed login alert to admin
#
#        AUTHOR:  Team LocalHost
#       VERSION:  1.0
#       CREATED:  23/03/2019 14:38:58 AM IST
#===============================================================================


PATH=/bin:/usr/bin

username=$(grep "failure" /var/log/auth.log | tail -1 | cut -d '=' -f 8)
hostname=$(hostname)
timestamp=$(date)

# cURL request to append data in GraphQl Hasura
/usr/bin/curl 'https://for2-accessdenied.herokuapp.com/v1alpha1/graphql' \
-H 'Accept-Encoding: gzip, deflate, br' \
-H 'content-type: application/json' \
-H 'Accept: */*' \
-H 'Connection: keep-alive' \
--data-binary '{"query":"mutation {\n  insert_login_failed(objects: {hostname: \"'"$hostname"'\", timestamp: \"'"$timestamp"'\", username: \"'"$username"'\"}) {\n    affected_rows\n  }\n}\n","variables":null}' --compressed &$


exit 0

# sender="hostname@example.com"
# recepient="admingroup@example.com"
# subject="Privileged Account logon used"
# message="`env`"
#     echo "$message" | mail -s "$subject" -r "$sender" "$recepient"

# cURL request to append data in GraphQl Hasura
