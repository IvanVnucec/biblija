import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/search_result.dart';

List<SearchResult> searchBible(Bible bible, String query) {
  if (query.isEmpty) {
    return [];
  }

  String formatted(String text) => text.toLowerCase();

  final formattedQuery = formatted(query);

  var results = <SearchResult>[];
  for (final book in bible.books) {
    for (final chapter in book.chapters) {
      final formattedChapter = formatted(chapter.content);

      if (formattedChapter.contains(formattedQuery)) {
        final first = formattedChapter.indexOf(formattedQuery);
        final last = first + formattedQuery.length;

        results.add(SearchResult(
          book: book,
          chapter: chapter,
          match: SearchResultMatch(first: first, last: last),
        ));
      }
    }
  }

  return results;
}
