import smtplib
import mimetypes
from email import encoders
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email.message import EmailMessage
from email.mime.multipart import MIMEMultipart

msg = MIMEMultipart()
user = "" #Enter sender's email address
passwd = "" #Enter sender's password
msg['Subject'] = "Alert! Site has been modified"
msg['From'] = user
msg['To'] = "" #Enter receiver's email address
msgContent = "Hi there,\n\nPlease find attached."
ctype, encoding = mimetypes.guess_type("DIFF.txt")
if ctype is None or encoding is not None:
    ctype = "application/octet-stream"
Content = MIMEText(msgContent,'plain')
maintype, subtype = ctype.split("/", 1)
fp = open("DIFF.txt","rb")
attachment = MIMEBase(maintype, subtype)
attachment.set_payload(fp.read())
encoders.encode_base64(attachment)
attachment.add_header("Content-Disposition", "attachment", filename="DIFF.txt")
msg.attach(attachment)
msg.attach(Content)
with smtplib.SMTP_SSL('smtp.gmail.com',465) as smtp:
    smtp.login(user,passwd)
    smtp.send_message(msg)
print("Done")
