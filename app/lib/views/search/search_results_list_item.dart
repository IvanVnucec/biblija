import 'package:bible/models/bible/search_result.dart';
import 'package:flutter/material.dart';

import 'highlighted_text.dart';

class SearchResultListItem extends StatelessWidget {
  const SearchResultListItem({
    super.key,
    required this.result,
  });

  final SearchResult result;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          result.chapter.name,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.labelLarge?.fontSize ?? 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        HighlightedText(
          text: result.chapter.content,
          first: result.match.first,
          last: result.match.last,
          maxLines: 3,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
