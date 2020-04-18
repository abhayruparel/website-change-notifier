#!/bin/bash
# Author Abhay Ruparel
function1()
{

echo #################
echo Cleaning all html files!
rm *.html
echo #################
	#check if we need to generate.
		shaOne=$(cat shaKaFile)
		
		echo 1. Downloading the site as of $(date)
		wget -q https://sites.google.com/a/ict.gnu.ac.in/sitenews/home/2020---even-sem
		tail -n +67 2020---even-sem > first.html # getting rid of a dynamic stuff from website source to avoid ambiguity of sha gen
		newSha=$(shasum first.html)
		if [ "$newSha" != "$shaOne" ]
		then
			echo 2. Changes Found
			python3 mail.py
			echo 3. Mail command of python run complete.
			echo 4. Now let me change the shaKaFile with newSha variable so next time when the file runs it has new sha.
			shasum first.html > shaKaFile
			echo 5. Updating shaKaFile with $newSha done.
		else
			echo 2. Nothing changed exiting script. I will now run after 15m.
		fi
}

function1
