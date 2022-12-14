import 'bible.dart';

class SearchResult {
  const SearchResult({
    required this.book,
    required this.chapter,
    required this.match,
  });

  final Book book;
  final Chapter chapter;
  final SearchResultMatch match;
}

class SearchResultMatch {
  const SearchResultMatch({
    required this.first,
    required this.last,
  });

  final int first;
  final int last;
}
