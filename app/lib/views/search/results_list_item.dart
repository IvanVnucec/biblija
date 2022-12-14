import 'package:flutter/material.dart';

class SearchResultListItem extends StatelessWidget {
  const SearchResultListItem({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize:
                Theme.of(context).textTheme.labelLarge?.fontSize ??
                    16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          content,
          maxLines: 3,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
