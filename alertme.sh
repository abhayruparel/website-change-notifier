#!/bin/bash
# Author Abhay Ruparel
TODAY=$(TZ=":Asia/Kolkata" date)

function1()
{
# Specify colors utilized in the terminal
red=$(tput setaf 1)                        #  red
txtrst=$(tput sgr0)                        #  Reset

#detect path where the script is running
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
if [ -z "$SCRIPT_DIR" ] ; then
    # error; for some reason, the path is not accessible
    echo "${red}Can not read run path"
    echo "Build can not continue"${txtrst}
    exit 1  # fail
fi
echo "Script dir is $SCRIPT_DIR"
echo "#################"
echo Cleaning all html files!
rm $SCRIPT_DIR/*.html $SCRIPT_DIR/2020---even-sem
echo "#################"
	#check if we need to generate.
		shaOne=$(cat $SCRIPT_DIR/shaKaFile)
		
		echo "1. Downloading the site as of $TODAY"
		wget -q -O $SCRIPT_DIR/2020---even-sem https://sites.google.com/a/ict.gnu.ac.in/sitenews/home/2020---even-sem
		tail -n +67 $SCRIPT_DIR/2020---even-sem > $SCRIPT_DIR/first.html # getting rid of a dynamic stuff from website source to avoid ambiguity of sha gen
		newSha=$(shasum $SCRIPT_DIR/first.html | awk '{ print $1 }')
		echo "comparing $newSha with $shaOne"
		if [ "$newSha" != "$shaOne" ]
		then
			echo "2. Changes Found"
			echo "Storing newSha in newSha.log"
			if [ -z "$SCRIPT_DIR/newSha.log" ] ; then
				touch $SCRIPT_DIR/newSha.log
				echo -e "$newSha\n" >> $SCRIPT_DIR/newSha.log
			else
				echo -e "$newSha\n" >> $SCRIPT_DIR/newSha.log
			fi
			python3 $SCRIPT_DIR/mail.py
			echo "3. Mail command of python run complete."
			echo "4. Now let me change the shaKaFile with newSha variable so next time when the file runs it has new sha."
			echo $newSha > $SCRIPT_DIR/shaKaFile
			echo "5. Updating shaKaFile with $newSha done."
			if [ -z "$SCRIPT_DIR/first.html.old" ]; then
				echo "Saving the first.html as first.html.old to store diff."
				mv $SCRIPT_DIR/first.html $SCRIPT_DIR/first.html.old
			else
				echo -e "$(diff first.html first.html.old)" >> $SCRIPT_DIR/DIFF.txt
				echo -e "#### \n" >> $SCRIPT_DIR/DIFF.txt
				rm $SCRIPT_DIR/first.html.old $SCRIPT_DIR/first.html
			fi
		else
			echo "2. Nothing changed exiting script. I will now run after 15m."
		fi
}

function1