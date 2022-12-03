class Chapter {
  Chapter(this.name, this.content);

  final String name;
  final String content;
}

class Book {
  Book(this.name, this.chapters);

  final String name;
  final List<Chapter> chapters;
}

class Bible {
  Bible(this.books);

  final List<Book> books;
}
