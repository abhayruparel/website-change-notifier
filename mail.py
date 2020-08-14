import smtplib
import mimetypes
import os
from email import encoders
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email.message import EmailMessage
from email.mime.multipart import MIMEMultipart

msg = MIMEMultipart()
user = os.environ.get('id') #Enter sender's email address
passwd = os.environ.get('pass')
msg['Subject'] = "Alert! Site has been modified"
msg['From'] = user
msg['To'] = "abhayruparel2000@gmail.com" #Enter receiver's email address
msgContent = "Hi there,\n\nPlease find attached."
ctype, encoding = mimetypes.guess_type("DIFF.txt")
if ctype is None or encoding is not None:
    ctype = "application/octet-stream"
Content = MIMEText(msgContent,'plain')

if os.path.isfile(os.path.dirname(os.path.abspath(__file__)) + '/DIFF.txt'):
    maintype, subtype = ctype.split("/", 1)
    fp = open(os.path.dirname(os.path.abspath(__file__)) + "/DIFF.txt","rb")
    attachment = MIMEBase(maintype, subtype)
    attachment.set_payload(fp.read())
    encoders.encode_base64(attachment)
    attachment.add_header("Content-Disposition", "attachment", filename="DIFF.txt")
    msg.attach(attachment)
else:
    print ("DIFF.txt file does not exist")
msg.attach(Content)
with smtplib.SMTP_SSL('smtp.gmail.com',465) as smtp:
    smtp.login(user,passwd)
    smtp.send_message(msg)
print("Done")
