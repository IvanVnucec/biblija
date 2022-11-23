import 'package:flutter/material.dart';

class ElevatedRoundedButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  const ElevatedRoundedButton({
    super.key,
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 8),
      shape: const CircleBorder(),
      backgroundColor: const Color.fromARGB(255, 67, 67, 67),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: Icon(
          iconData,
          size: 30,
        ),
      ),
    );
  }
}
