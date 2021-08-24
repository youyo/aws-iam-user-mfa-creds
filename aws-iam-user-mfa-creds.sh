#!/bin/bash

set -ue

serial_number="${1}"

get_session_token(){
	tmpfile=`mktemp`
	echo -n 'Input token-code: '
	read token_code
	aws sts get-session-token \
		--serial-number ${serial_number} \
		--token-code ${token_code} > ${tmpfile}
	echo "export AWS_ACCESS_KEY_ID=`cat ${tmpfile} | jq '.Credentials.AccessKeyId'`"
	echo "export AWS_SECRET_ACCESS_KEY=`cat ${tmpfile} | jq '.Credentials.SecretAccessKey'`"
	echo "export AWS_SESSION_TOKEN=`cat ${tmpfile} | jq '.Credentials.SessionToken'`"
}

main(){
	get_session_token
}

main
