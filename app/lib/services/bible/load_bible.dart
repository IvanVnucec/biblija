import 'dart:convert';

import 'package:bible/models/bible/bible.dart';
import 'package:flutter/material.dart';

Future<Bible> loadBible(BuildContext context, String path) {
  return DefaultAssetBundle.of(context).loadString('assets/bible.json').then(
    (jsonResponse) {
      List jsonObject = jsonDecode(jsonResponse);

      final books = jsonObject.map(
        (book) {
          final String bookName = book[0];
          final List chapterList = book[1];

          final chapters = chapterList.map(
            (chapter) {
              final chapterName = chapter[0];
              final chapterContents = chapter[1];

              return Chapter(chapterName, chapterContents);
            },
          ).toList();

          return Book(bookName, chapters);
        },
      ).toList();

      return Bible(books);
    },
  );
}
