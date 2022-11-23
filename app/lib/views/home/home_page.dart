import 'package:bible/components/elevated_rounded_button.dart';
import 'package:bible/views/home/zavjet_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 195, 103),
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
                  color: const Color.fromRGBO(139, 26, 16, 1),
                ),
              ),
              const Text(
                "Krščanske sadašnjosti",
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 40, 40, 40),
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ZavjetButton(
                heading: 'stari zavjet',
                onPressed: () {},
              ),
              ZavjetButton(
                heading: 'novi zavjet',
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
