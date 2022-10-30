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

# Sort naturally Bible book chapters
for books in data:
    book_chapters = books[1]
    natural_sort(book_chapters, key=lambda x: x[0])

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

# Rename bible books and chapters properly
bible_books_proper_names = [
    "Knjiga Postanka",
    "Knjiga Izlaska",
    "Levitski zakonik",
    "Knjiga Brojeva",
    "Ponovljeni zakon",
    "Jošua",
    "Knjiga o Sucima",
    "Knjiga o Ruti",
    "Prva knjiga o Samuelu",
    "Druga knjiga o Samuelu",
    "Prva knjiga o Kraljevima",
    "Druga knjiga o Kraljevima",
    "Prva Knjiga Ljetopisa",
    "Druga Knjiga Ljetopisa",
    "Ezra",
    "Nehemija",
    "Tobija",
    "Judita",
    "Estera",
    "Prva knjiga o Makabejcima",
    "Druga knjiga o Makabejcima",
    "Knjiga o Jobu",
    "Psalmi",
    "Mudre izreke",
    "Propovjednik",
    "Pjesma nad pjesmama",
    "Knjiga Mudrosti",
    "Knjiga Sirahova",
    "Izaija",
    "Jeremija",
    "Tužaljke",
    "Baruh",
    "Ezekiel",
    "Daniel",
    "Hošea",
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
    "Evanđelje po Mateju",
    "Evanđelje po Marku",
    "Evanđelje po Luki",
    "Evanđelje po Ivanu",
    "Djela apostolska",
    "Poslanica Rimljanima",
    "Prva poslanica Korinćanima",
    "Druga poslanica Korinćanima",
    "Poslanica Galaćanima",
    "Poslanica Efežanima",
    "Poslanica Filipljanima",
    "Poslanica Kološanima",
    "Prva poslanica Solunjanima",
    "Druga poslanica Solunjanima",
    "Prva poslanica Timoteju",
    "Druga poslanica Timoteju",
    "Poslanica Titu",
    "Poslanica Filemonu",
    "Poslanica Hebrejima",
    "Jakovljeva poslanica",
    "Prva Petrova poslanica",
    "Druga Petrova poslanica",
    "Prva Ivanova poslanica",
    "Druga Ivanova poslanica",
    "Treća Ivanova poslanica",
    "Poslanica Jude apostola",
    "Otkrivenje",
]

for i, book in enumerate(bible_proper_sort):
    book[0] = bible_books_proper_names[i]
    #print(book[0])
    for j, chapter in enumerate(book[1]):
        chapter[0] = bible_books_proper_names[i] + " - " + str(j+1)
        #print("\t" + chapter[0])

with open(f"{BIBLE_PATH}/bible.json", 'w', encoding='utf-8') as f:
    json.dump(bible_proper_sort, f, ensure_ascii=False, indent=4)

print("Now you can copy bible.json into Flutter assets folder. ")
