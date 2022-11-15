import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // TODO: add colors based on the theme
          ),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

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
          const HomePageButtons(),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomePageSettingsButton(),
              HomePageBookmarkButton(),
              HomePageLastReadButton(),
              HomePageSearchButton(),
            ],
          ),
        ],
      ),
    );
  }
}

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

class HomePageButtons extends StatelessWidget {
  const HomePageButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StariZavjetButton(),
        NoviZavjetButton(),
      ],
    );
  }
}

class StariZavjetButton extends ZavjetButton {
  StariZavjetButton({super.key})
      : super(
          heading: 'stari zavjet',
          onPressed: () {},
        );
}

class NoviZavjetButton extends ZavjetButton {
  NoviZavjetButton({super.key})
      : super(
          heading: 'novi zavjet',
          onPressed: () {},
        );
}

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
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: const Color.fromARGB(255, 173, 33, 20),
      padding: const EdgeInsets.symmetric(vertical: 20),
      minimumSize: const Size(170, 85),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Text(heading.toUpperCase()),
    );
  }
}

class HomePageSettingsButton extends HomePageRoundedButton {
  HomePageSettingsButton({super.key})
      : super(
          iconData: Icons.settings,
          onPressed: () {},
        );
}

class HomePageBookmarkButton extends HomePageRoundedButton {
  HomePageBookmarkButton({super.key})
      : super(
          iconData: Icons.bookmark,
          onPressed: () {},
        );
}

class HomePageLastReadButton extends HomePageRoundedButton {
  HomePageLastReadButton({super.key})
      : super(
          iconData: Icons.restore,
          onPressed: () {},
        );
}

class HomePageSearchButton extends HomePageRoundedButton {
  HomePageSearchButton({super.key})
      : super(
          iconData: Icons.search,
          onPressed: () {},
        );
}

class HomePageRoundedButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  const HomePageRoundedButton({
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


/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:preload_page_view/preload_page_view.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final String title = 'Biblija';

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<List<Knjiga>> dohvatiListuKnjiga() {
    return DefaultAssetBundle.of(context)
        .loadString('assets/bible.json')
        .then((jsonResponse) {
      List jsonObject = jsonDecode(jsonResponse);
      List<Knjiga> knjige = jsonObject
          .map((item) => Knjiga(
                title: item[0],
                poglavlja: item[1],
              ))
          .toList();
      return knjige;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Knjige")),
      body: FutureBuilder<List<Knjiga>>(
        future: dohvatiListuKnjiga(),
        builder: (BuildContext context, AsyncSnapshot<List<Knjiga>> snapshot) {
          List<Knjiga> children = [];

          if (snapshot.hasData) {
            children = snapshot.data!;
          } else if (snapshot.hasError) {
          } else {}

          return Scrollbar(
            child: ListView.separated(
              itemCount: children.length,
              itemBuilder: (context, index) => children[index],
              separatorBuilder: (context, index) => const Divider(),
            ),
          );
        },
      ),
    );
  }
}

class Knjiga extends StatelessWidget {
  final String title;
  final List poglavlja;

  const Knjiga({super.key, required this.title, required this.poglavlja});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) =>
                ListaPoglavlja(title: title, poglavlja: poglavlja))));
      },
    );
  }
}

class Poglavlje extends StatelessWidget {
  final String title;
  final List poglavlja;

  const Poglavlje({super.key, required this.title, required this.poglavlja});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => PregledPoglavlja(
                  title: title,
                  poglavlja: poglavlja,
                ))));
      },
    );
  }
}

class ListaPoglavlja extends StatelessWidget {
  final String title;
  final List poglavlja;

  const ListaPoglavlja(
      {super.key, required this.title, required this.poglavlja});

  List<Poglavlje> dohvatiListuPoglavlja() {
    return poglavlja
        .map((item) => Poglavlje(title: item[0], poglavlja: poglavlja))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Poglavlje> listaPoglavlja = dohvatiListuPoglavlja();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Scrollbar(
        child: ListView.separated(
          itemCount: listaPoglavlja.length,
          itemBuilder: (context, index) => listaPoglavlja[index],
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}

class PregledPoglavlja extends StatefulWidget {
  final String title;
  final List poglavlja;

  const PregledPoglavlja(
      {super.key, required this.title, required this.poglavlja});

  @override
  State<PregledPoglavlja> createState() => _PregledPoglavljaState();
}

class _PregledPoglavljaState extends State<PregledPoglavlja> {
  String _title = '';

  @override
  void initState() {
    super.initState();
    _title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    final PreloadPageController controller = PreloadPageController(
        initialPage: widget.poglavlja
            .indexWhere((element) => element[0] == widget.title));

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: PreloadPageView.builder(
          onPageChanged: (value) {
            setState(() {
              _title = widget.poglavlja[value][0];
            });
          },
          preloadPagesCount: 3,
          controller: controller,
          physics: const CustomPageViewScrollPhysics(),
          itemCount: widget.poglavlja.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: SelectableHtml(
                      data: widget.poglavlja[index][1],
                      style: {
                        "*": Style(
                          fontSize: FontSize(20.0),
                        ),
                        // TODO: add verticalAlign: VerticalAlign.sup, once it is supported
                        "span": Style(fontSize: FontSize(80, Unit.percent))
                      },
                    )));
          }),
    );
  }
}

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 50,
        stiffness: 100,
        damping: 1.5,
      );
}
*/
