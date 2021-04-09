# Website content change notifier
A python, shell program that scrapes webpage and checks for changes in a website and sends an email if page is updated

### Features

- It monitors the given page and sends you an email as soon as there is a change observed on a webpage.
- Currently I'm using it for the purpose of monitoring college's notice board. As soon as there is an announcement I get a mail regarding the same. 
- Basically it saves you the trouble from missing an important announcement.


### Tools and technology
* Python 3.
* BeautifulSoup from bs4.
* Bash.
* SMTP for mails.
* [shasum](http://manpages.ubuntu.com/manpages/trusty/man1/shasum.1.html)

### Usage [ skip to [Last Step](https://github.com/abhayruparel/website-change-notifier#set-a-cronjob) if you  are going to use github actions]

### Check if python is already installed?
```
python --version
```
### If python isn't pre installed in your OS
```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.7
```
### Install requirements
```
pip install -r requirements.txt
```
### Set a cronjob 
```
crontab -e
#every 10 mins
*/10 * * * * bash path/to/alertme.sh
```
### Setup email "id" and password "pass" as environment variable or github secret.
### Done
