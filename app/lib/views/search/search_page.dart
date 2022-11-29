import 'package:flutter/material.dart';

import 'results_list_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _searchResults = <ResultsListItem>[];

  Future<List<ResultsListItem>> _search(String query) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => List<ResultsListItem>.generate(
          growable: false,
          query.length,
          (index) => ResultsListItem(
                title: 'Ime poglavlja ${index + 1}',
                content: query * (index + 1),
              )),
    );
  }

  void _onChanged(String query) async {
    final searchResults = await _search(query);
    if (mounted) {
      setState(() {
        _searchResults = searchResults;
      });
    }
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
