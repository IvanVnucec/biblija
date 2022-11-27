import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  Widget buildFloatingSearchBar(BuildContext context) {
    return FloatingSearchAppBar(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, index) => ListTile(
          title: Text('Item $index'),
        ),
      ),
      onQueryChanged: (query) {},
      onSubmitted: (query) {},
      alwaysOpened: true,
      hint: 'Search...',
      transitionDuration: const Duration(milliseconds: 300),
      transitionCurve: Curves.easeInOut,
      debounceDelay: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          buildFloatingSearchBar(context),
        ],
      ),
    );
  }
}
