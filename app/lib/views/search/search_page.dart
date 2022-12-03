import 'package:bible/models/bible/bible.dart';
import 'package:bible/services/bible/search_bible.dart';
import 'package:flutter/material.dart';

import 'results_list_item.dart';

class SearchPage extends StatefulWidget {
  final Future<Bible> bible;

  const SearchPage({super.key, required this.bible});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _searchResults = <ResultsListItem>[];

  Future<List<ResultsListItem>> _search(String query) {
    return widget.bible.then((bible) {
      final results = searchBible(bible, query);

      var retval = <ResultsListItem>[];
      for (final r in results) {
        for (final _ in r.matches) {
          retval.add(
            ResultsListItem(
              title: '${r.book.name}, ${r.chapter.name}',
              content: r.chapter.content,
            ),
          );
        }
      }

      return Future.value(retval);
    });
  }

  void _onChanged(String query) async {
    _search(query).then((searchResults) {
      if (mounted) {
        setState(() {
          _searchResults = searchResults;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: _onChanged,
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search...',
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return _searchResults[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
