import 'package:flutter/material.dart';

class HomePageLogo extends StatelessWidget {
  const HomePageLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Image.asset(
        'assets/holy_spirit.png',
        height: 150,
        color: Theme.of(context).primaryColorDark,
      ),
    );
  }
}
