#!/bin/bash
sendLogToTg() {
	CURL_OPTIONS="-s --form document=@log-$IST_LOCAL.log --form caption=<- --form-string chat_id=$TG_CHAT_ID https://api.telegram.org/bot${TG_BOT_API_KEY}/sendDocument"
	
	echo "Executing: curl $CURL_OPTIONS"
	response=`curl $CURL_OPTIONS <<< "$TEXT"`

	if [[ "$response" != '{"ok":true'* ]]; then
			echo "Telegram reported an error:"
			echo $response
			# If you need yor program to stop if tg returns error, then uncomment the below
			# echo "Quitting."
			# exit 1
	fi
}
sendLogToTg
