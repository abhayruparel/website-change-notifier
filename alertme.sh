#!/bin/sh
#download site
wget -q https://sites.google.com/a/ict.gnu.ac.in/sitenews/home/2020---even-sem 
tail -n +67 2020---even-sem > first.html #removing var webspace

#deleting site source
chmod a+w 2020---even-sem
rm 2020---even-sem

#getting sha
oldsha=$(shasum first.html)
mv first.html old.html



while true
do

# downloading new source
wget -q https://sites.google.com/a/ict.gnu.ac.in/sitenews/home/2020---even-sem
tail -n +67 2020---even-sem > first.html

#deleting site source
chmod a+w 2020---even-sem
rm 2020---even-sem

newsha=$(shasum first.html)
mv first.html new.html

#lets compare it now
if [ "$oldsha" = "$newsha" ]
        then
                echo "no changes found" 
        else
                echo "executing the mail program as changes found"
                python3 mail.py
                exit 0
fi
done
