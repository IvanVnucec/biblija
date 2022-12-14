import 'package:bible/components/elevated_rounded_button.dart';
import 'package:bible/models/bible/bible.dart';
import 'package:bible/services/bible/load_bible.dart';
import 'package:bible/views/bookmarks/bookmarks_page.dart';
import 'package:bible/views/home/zavjet_button.dart';
import 'package:bible/views/search/search_page.dart';
import 'package:bible/views/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  late Future<Bible> bible;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bible = loadBible(context, 'assets/bible.json');

    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Text(
            "Biblija",
            style: GoogleFonts.unifrakturCook(
              fontSize: 120,
            ),
          ),
          const Spacer(flex: 2),
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
          const Spacer(flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedRoundedButton(
                iconData: Icons.settings,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()),
                  );
                },
              ),
              ElevatedRoundedButton(
                iconData: Icons.bookmark,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BookmarksPage()),
                  );
                },
              ),
              ElevatedRoundedButton(
                iconData: Icons.restore,
                onPressed: () {},
              ),
              ElevatedRoundedButton(
                iconData: Icons.search,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage(bible: bible)),
                  );
                },
              ),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
