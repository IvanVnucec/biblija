import json
import re

def natural_sort(list, key=lambda s:s):
    """
    Sort the list into natural alphanumeric order.
    """
    def get_alphanum_key_func(key):
        convert = lambda text: int(text) if text.isdigit() else text 
        return lambda s: [convert(c) for c in re.split('([0-9]+)', key(s))]
    sort_key = get_alphanum_key_func(key)
    list.sort(key=sort_key)

# Load data
BIBLE_PATH = 'bible'

with open(f"{BIBLE_PATH}/bible.json", 'r', encoding='utf-8') as f:
    data = json.load(f)

for books in data:
    book_name = books[0]
    #print(book_name)
    book_chapters = books[1]
    natural_sort(book_chapters, key=lambda x: x[0])
    for chapter in book_chapters:
        chapter_name = chapter[0]
        #print('\t' + chapter_name)
        chapter_html = chapter[1][:100]
        #print("\t\t" + chapter_html)

# Sort Bible books properly
bible_books_proper_order = [
    "Knjiga Postanka",
    "Izlazak",
    "Levitski zakonik",
    "Brojevi",
    "Ponovljeni zakon",
    "Josua",
    "Suci",
    "Ruta",
    "Samuel I",
    "Samuel II",
    "Kraljevi I",
    "Kraljevi II",
    "Ljetopisi I",
    "Ljetopisi II",
    "Ezra",
    "Nehemija",
    "Tobija",
    "Judita",
    "Estera",
    "Makabejci I",
    "Makabejci II",
    "Job",
    "Psalmi",
    "Izreke",
    "Propovjednik",
    "Pjesma nad pjesmama",
    "Mudrost",
    "Sirah",
    "Izaija",
    "Jeremija",
    "Tuzaljke",
    "Baruh",
    "Ezekiel",
    "Daniel",
    "Hosea",
    "Joel",
    "Amos",
    "Obadija",
    "Jona",
    "Mihej",
    "Nahum",
    "Habakuk",
    "Sefanija",
    "Hagaj",
    "Zaharija",
    "Malahija",
    "Matej",
    "Marko",
    "Luka",
    "Ivan",
    "Djela",
    "Rimljanima",
    "Korincanima I",
    "Korincanima II",
    "Galacanima",
    "Efezanima",
    "Filipljanima",
    "Kolosanima",
    "Solunjanima I",
    "Solunjanima II",
    "Timoteju I",
    "Timoteju II",
    "Titu",
    "Filemonu",
    "Hebrejima",
    "Jakovljeva poslanica",
    "I. Petrova poslanica",
    "II. Petrova poslanica",
    "I. Ivanova poslanica",
    "II. Ivanova poslanica",
    "III. Ivanova poslanica",
    "Poslanica Jude apostola",
    "Otkrivenje",
]
bible_proper_sort = []
book_names = [d[0] for d in data]
for i in range(len(bible_books_proper_order)):
    index = book_names.index(bible_books_proper_order[i])
    bible_proper_sort.append(data[index])

with open(f"{BIBLE_PATH}/bible.json", 'w', encoding='utf-8') as f:
    json.dump(bible_proper_sort, f, ensure_ascii=False, indent=4)
