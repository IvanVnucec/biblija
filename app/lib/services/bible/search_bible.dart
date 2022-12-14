import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/search_result.dart';

List<SearchResult> searchBible(Bible bible, String query) {
  if (query.isEmpty) {
    return [];
  }

  var results = <SearchResult>[];
  for (final book in bible.books) {
    for (final chapter in book.chapters) {
      if (chapter.content.toLowerCase().contains(query.toLowerCase())) {
        results.add(SearchResult(book, chapter));
      }
    }
  }

  return results;
}
