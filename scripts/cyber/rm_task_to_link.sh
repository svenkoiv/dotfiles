#!/bin/bash

SUBJECT=$(curl -n -s "https://rm-int.cyber.ee/ito/issues/${1}.xml" | xq | jq -r ".issue.subject")

echo $SUBJECT

exit 0
