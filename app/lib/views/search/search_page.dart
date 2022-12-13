import 'package:bible/models/bible/bible.dart';
import 'package:bible/services/bible/search_bible.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'results_list_item.dart';

class SearchPage extends StatefulWidget {
  final Future<Bible> bible;

  const SearchPage({super.key, required this.bible});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _searchResults = <ResultsListItem>[];

  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  Future<List<ResultsListItem>> _search(String query) {
    return widget.bible.then(
      (bible) {
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

        return retval;
      },
    );
  }

  void _onChanged(String query) async {
    _search(query).then(
      (searchResults) {
        if (mounted) {
          setState(() {
            _searchResults = searchResults;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              autofocus: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                fillColor: Theme.of(context).appBarTheme.backgroundColor,
              ),
              onChanged: _onChanged,
            ),
            floating: false,
            pinned: true,
            snap: false,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  _searchFocusNode.requestFocus();
                  SystemChannels.textInput.invokeMethod('TextInput.show');
                },
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _searchResults[index];
                },
                childCount: _searchResults.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
