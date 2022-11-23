import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchAppBar(
        alwaysOpened: true,
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (_, index) => ListTile(
            title: Text('Item $index'),
          ),
        ),
        onQueryChanged: (query) {},
        onSubmitted: (query) {},
      ),
    );
  }
}
