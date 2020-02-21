import os
import smtplib
from email.message import EmailMessage

user = "#email"
passwd = "#password"

with smtplib.SMTP_SSL('smtp.gmail.com',465) as smtp:
    msg = EmailMessage()
    msg['Subject'] = "change at site news detected!"
    msg['From'] = user
    msg['To'] = 'gamingdynamo121@gmail.com'
    msg.set_content('Hi there is a change check https://sites.google.com/a/ict.gnu.ac.in/sitenews/home/2020---even-sem ')
    smtp.login(user,passwd)
    smtp.send_message(msg)
    print ("Done")
