import 'package:bible/components/elevated_rounded_button.dart';
import 'package:bible/views/home/zavjet_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 80),
          Column(
            children: [
              Text(
                "Biblija",
                style: GoogleFonts.unifrakturCook(
                  fontSize: 120,
                ),
              ),
              const Text(
                "Krščanske sadašnjosti",
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ZavjetButton(
                heading: 'Stari zavjet',
                onPressed: () {},
              ),
              ZavjetButton(
                heading: 'Novi zavjet',
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedRoundedButton(
                iconData: Icons.settings,
                onPressed: () {},
              ),
              ElevatedRoundedButton(
                iconData: Icons.bookmark,
                onPressed: () {},
              ),
              ElevatedRoundedButton(
                iconData: Icons.restore,
                onPressed: () {},
              ),
              ElevatedRoundedButton(
                iconData: Icons.search,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
