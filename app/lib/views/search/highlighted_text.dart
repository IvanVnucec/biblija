import 'package:flutter/material.dart';

class HighlightedText extends StatelessWidget {
  final String text;
  final int first;
  final int last;
  final int maxLines;
  final bool softWrap;
  final TextOverflow overflow;

  const HighlightedText({
    super.key,
    required this.text,
    required this.first,
    required this.last,
    required this.maxLines,
    required this.softWrap,
    required this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
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
