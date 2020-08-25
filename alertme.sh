#!/bin/bash

#paratmeters
TODAY=$(TZ=":Asia/Kolkata" date)
IST_LOCAL=$(TZ=":Asia/Kolkata" date +%A_%F)

SCRAPE()
{
python3 scraper.py > $1
}
COMPARE()
{
shaFirst=$(shasum first | awk '{ print $1 }')
shaSecond=$(shasum second | awk '{ print $1 }')
if [ "$shaFirst" != "$shaSecond" ]
then
	echo "change detected."
	diff first second > DIFF.txt
	rm first second
	echo "Running mail script!"
	python3 mail.py
	rm DIFF.txt
else
	echo "No change detected"
	# as there are no changes lets just nuke second.
	rm second
fi
}
main()
{
if [ -f first ]
then
	SCRAPE second
else
	SCRAPE first
	SCRAPE second
fi
 # log those first and second html.
 echo "==============================================================================" >> log-$IST_LOCAL.log
 echo $TODAY >> log-$IST_LOCAL.log
 echo -e "First scrape file:\n" >> log-$IST_LOCAL.log
 cat first >> log-$IST_LOCAL.log
 echo -e "\nSecond scrape\n" >> log-$IST_LOCAL.log
 cat second >> log-$IST_LOCAL.log
 echo "==============================================================================" >> log-$IST_LOCAL.log
COMPARE
}
main
