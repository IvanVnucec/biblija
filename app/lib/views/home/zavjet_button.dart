import 'package:flutter/material.dart';

class ZavjetButton extends StatelessWidget {
  final String heading;
  final VoidCallback onPressed;

  const ZavjetButton({
    super.key,
    required this.heading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.6,
      ),
      padding: const EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Text(heading),
    );
  }
}
