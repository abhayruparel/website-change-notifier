#!/bin/bash
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
COMPARE
}
main
