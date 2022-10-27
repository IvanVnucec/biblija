"""
Download all the bible text from http://www.ks.hr/hr-biblija-text/ into bible folder.
Caution: This might overload their servers because no delay is implemented. Use with caution.
"""

import requests
from bs4 import BeautifulSoup
from pathlib import Path
import json


class Book:
    def __init__(self, name='', url='') -> None:
        self.name = name
        self.url = url
        self.chapters = []


class Chapter:
    def __init__(self, name='', url='') -> None:
        self.name = name
        self.url = url
        self.html = ''


class Bible:
    def __init__(self) -> None:
        self.books = []


KS_URL = "http://www.ks.hr/hr-biblija-text/"

bible = Bible()

req = requests.get(KS_URL)
soup = BeautifulSoup(req.content, 'html.parser')
aa = soup.find_all('a')[4:]
book_names = [a.get_text() for a in aa]
for book_name in book_names:
    book_url = KS_URL + book_name + '/'
    book_name = book_name.replace("__", "_").replace("_", " ")
    bible.books.append(Book(name=book_name, url=book_url))

for book in bible.books:
    req = requests.get(book.url)
    soup = BeautifulSoup(req.content, 'html.parser')
    aa = soup.find_all('a')[4:]
    chapter_names = [a.get_text().replace(".html", "") for a in aa]
    for chapter_name in chapter_names:
        chapter_url = book.url + chapter_name + ".html"
        chapter_name = chapter_name.replace("__", "_").replace("_", " ")
        book.chapters.append(Chapter(name=chapter_name, url=chapter_url))

for book in bible.books:
    print(book.name, book.url)
    for chapter in book.chapters:
        req = requests.get(chapter.url)
        chapter.html = str(BeautifulSoup(req.content, 'html.parser'))
        print('\t', chapter.name, chapter.url)

# Save data
BIBLE_PATH = 'bible'
Path(BIBLE_PATH).mkdir(parents=True, exist_ok=True)

bible_ser = {}
for book in bible.books:
    print(book.name)
    chapter_ser = {}
    for chapter in book.chapters:
        chapter_ser[chapter.name] = chapter.html
        bible_ser[book.name] = chapter_ser

with open(f"{BIBLE_PATH}/bible.json", 'w', encoding='utf-8') as f:
    json.dump(bible_ser, f, ensure_ascii=False, indent=4)
