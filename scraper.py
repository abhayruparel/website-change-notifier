import requests
from bs4 import BeautifulSoup

page_url = 'https://sites.google.com/a/ict.gnu.ac.in/sitenews/home/2020---odd-sem/all-news---odd-sem-2020'
page = requests.get(page_url)

page_raw = BeautifulSoup(page.content, 'html.parser')

notifs = page_raw.find_all("div", class_="announcement")

for notif in notifs:
    main_elem = notif.find('h4')
    sec_elem = notif.find('a')['href']
    if None in (main_elem, sec_elem):
        continue
    print(main_elem.text.strip())
    print(f"https://sites.google.com{sec_elem}")
    print()
