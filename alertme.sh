#!/bin/bash

#paratmeters
TODAY=$(TZ=":Asia/Kolkata" date)
IST_LOCAL=$(TZ=":Asia/Kolkata" date +%A_%F)
#TG_* parameters are set via /etc/environment variable
TG_BOT_API_KEY=$TG_BOT_API_KEY 
TG_CHAT_ID=$TG_CHAT_ID 

SCRAPE()
{
	python3 scraper.py > $1
}
COMPARE()
{
	shafirstScrape=$(shasum firstScrape | awk '{ print $1 }')
	shasecondScrape=$(shasum secondScrape | awk '{ print $1 }')
	if [ "$shafirstScrape" != "$shasecondScrape" ]
	then
		echo "change detected."
		diff secondScrape firstScrape > DIFF.txt
		rm firstScrape secondScrape
		echo "Running mail script!"
		python3 mail.py
		rm DIFF.txt
	else
		echo "No change detected"
		# as there are no changes lets just nuke secondScrape.
		rm secondScrape
	fi
}



main()
{
	if [ ! -d logs ]
	then
		mkdir logs
	fi
	if [ -f firstScrape ]
	then
		SCRAPE secondScrape
	else
		SCRAPE firstScrape
		SCRAPE secondScrape
	fi
	 # log those firstScrape and secondScrape html.
	 echo "================================================================" >> log-$IST_LOCAL.log
	 echo $TODAY >> logs/log-$IST_LOCAL.log
	 echo -e "firstScrape scrape file:\n" >> logs/log-$IST_LOCAL.log
	 cat firstScrape >> logs/log-$IST_LOCAL.log
	 echo -e "\nsecondScrape scrape\n" >> logs/log-$IST_LOCAL.log
	 cat secondScrape >> logs/log-$IST_LOCAL.log
	 echo "================================================================" >> log-$IST_LOCAL.log

	COMPARE
}
main
