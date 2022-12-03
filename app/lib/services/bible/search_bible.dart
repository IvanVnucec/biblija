import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/search_result.dart';

List<SearchResult> searchBible(Bible bible, String query) {
  var results = <SearchResult>[];

  if (query.isEmpty) {
    return results;
  }

  try {
    final exp = RegExp(query, caseSensitive: false);
    for (final book in bible.books) {
      for (final chapter in book.chapters) {
        final matches = exp.allMatches(chapter.content);
        if (matches.isNotEmpty) {
          results.add(SearchResult(book, chapter, matches));
        }
      }
    }
  } catch (_) {}

  return results;
}
