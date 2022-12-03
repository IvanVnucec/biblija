import 'bible.dart';

class SearchResult {
  const SearchResult(this.book, this.chapter, this.matches);

  final Book book;
  final Chapter chapter;
  final Iterable<RegExpMatch> matches;
}
