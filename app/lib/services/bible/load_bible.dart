import 'dart:convert';

import 'package:bible/models/bible/bible.dart';
import 'package:flutter/material.dart';

Future<Bible> loadBible(BuildContext context, String path) {
  return DefaultAssetBundle.of(context)
      .loadString('assets/bible.json')
      .then((jsonResponse) {
    List jsonObject = jsonDecode(jsonResponse);

    List<Book> books = [];
    for (List book in jsonObject) {
      final bookName = book[0];
      final chapterList = book[1];

      List<Chapter> chapters = [];
      for (List chapter in chapterList) {
        final chapterName = chapter[0];
        final chapterContent = chapter[1];

        chapters.add(Chapter(chapterName, chapterContent));
      }
      books.add(Book(bookName, chapters));
    }
    return Bible(books);
  });
}
