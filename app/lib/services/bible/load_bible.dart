import 'package:bible/models/bible/bible.dart';

Future<Bible> loadBible(String path) {
  final json = {
    'Knjiga Postanka': {
      'Knjga Postanka 1': 'Tekst Knjiga Postanka 1',
      'Knjga Postanka 2': 'Tekst Knjiga Postanka 2',
      'Knjga Postanka 3': 'Tekst Knjiga Postanka 3',
    },
    'Knjiga Izlaska': {
      'Knjga Izlaska 1': 'Tekst Knjiga Izlaska 1',
      'Knjga Izlaska 2': 'Tekst Knjiga Izlaska 2',
      'Knjga Izlaska 3': 'Tekst Knjiga Izlaska 3',
    }
  };

  var books = <Book>[];
  json.forEach((jsonBookName, jsonChapters) {
    var chapters = <Chapter>[];
    jsonChapters.forEach((chapterName, chapterContents) {
      chapters.add(Chapter(chapterName, chapterContents));
    });
    books.add(Book(jsonBookName, chapters));
  });

  return Future.value(Bible(books));
}
