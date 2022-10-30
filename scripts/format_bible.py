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

with open(f"{BIBLE_PATH}/bible.json", 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=4)
