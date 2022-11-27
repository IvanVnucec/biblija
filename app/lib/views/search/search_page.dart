import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'results_list_item.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  Widget buildFloatingSearchBar(BuildContext context) {
    return FloatingSearchAppBar(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        itemExtent: 106.0,
        itemCount: 15,
        itemBuilder: (context, index) => const ResultsListItem(
          title: 'Jošua 15,8',
          user: 'Odatle se preko doline Ben-Hinom s juga dizala k Jebusejskom obronku, to jest k Jeruzalemu. Potom se uspinjala na vrh gore koja prema zapadu gleda na dolinu Hinon i leži na sjevernom kraju doline Refaima.',
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
