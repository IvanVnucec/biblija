import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:preload_page_view/preload_page_view.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblija',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Biblija'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

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
      body: FutureBuilder<List<Widget>>(
        future: dohvatiListuKnjiga(),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          List<Widget> children = [];

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
            builder: ((context) =>
                PregledPoglavlja(title: title, poglavlja: poglavlja))));
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
        .map((item) => Poglavlje(
              title: item[0],
              poglavlja: poglavlja,
            ))
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
          itemCount: widget.poglavlja.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: SelectableHtml(
                      data: widget.poglavlja[index][1],
                      style: {
                        // TODO: add verticalAlign: VerticalAlign.sup, once it is supported
                        "span": Style(fontSize: FontSize(80, Unit.percent))
                      },
                    )));
          }),
    );
  }
}
