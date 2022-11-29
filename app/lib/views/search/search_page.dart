import 'package:flutter/material.dart';

import 'results_list_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Second text field: ${controller.text}');
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
                controller: controller,
                onChanged: (value) {},
                onEditingComplete: () {},
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
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) {
                  return ResultsListItem(
                    title: 'Ime poglavlja $index',
                    content: 'Neki tekst ' * index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
