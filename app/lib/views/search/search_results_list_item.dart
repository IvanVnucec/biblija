import 'package:bible/models/bible/search_result.dart';
import 'package:flutter/material.dart';

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
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4.0),
        HighlightedText(
          text: result.chapter.content,
          first: result.match.first,
          last: result.match.last,
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}

class HighlightedText extends StatelessWidget {
  final String text;
  final int first;
  final int last;

  const HighlightedText({
    super.key,
    required this.text,
    required this.first,
    required this.last,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      maxLines: 3,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      TextSpan(
        children: [
          TextSpan(
            text: text.substring(0, first),
          ),
          TextSpan(
            text: text.substring(first, last),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  backgroundColor: Theme.of(context)
                      .textSelectionTheme
                      .selectionColor
                      ?.withOpacity(0.75),
                ),
          ),
          TextSpan(
            text: text.substring(last),
          ),
        ],
      ),
    );
  }
}
