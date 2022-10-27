import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

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
  Future<List<Widget>> dohvatiListuKnjiga() {
    return DefaultAssetBundle.of(context)
        .loadString('assets/bible.json')
        .then((jsonResponse) {
      Map<String, dynamic> jsonObject = jsonDecode(jsonResponse);
      return jsonObject.keys
          .toList(growable: false)
          .map((name) => Knjiga(
                title: name,
                poglavlja: jsonObject[name],
              ))
          .toList();
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

          return ListView.separated(
            itemCount: children.length,
            itemBuilder: (context, index) => children[index],
            separatorBuilder: (context, index) => const Divider(),
          );
        },
      ),
    );
  }
}

class Knjiga extends StatelessWidget {
  final String title;
  final Map<String, dynamic> poglavlja;

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
  final Map<String, dynamic> poglavlja;

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
  final Map<String, dynamic> poglavlja;

  const ListaPoglavlja(
      {super.key, required this.title, required this.poglavlja});

  List<Widget> dohvatiListuPoglavlja() {
    return poglavlja.keys
        .toList(growable: false)
        .map((name) => Poglavlje(
              title: name,
              poglavlja: poglavlja,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listaPoglavlja = dohvatiListuPoglavlja();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        itemCount: listaPoglavlja.length,
        itemBuilder: (context, index) => listaPoglavlja[index],
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}

class PregledPoglavlja extends StatefulWidget {
  final String title;
  final Map<String, dynamic> poglavlja;
  final List<String> poglavljaKeys;

  PregledPoglavlja({super.key, required this.title, required this.poglavlja})
      : poglavljaKeys = poglavlja.keys.toList(growable: false);

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
    final PageController controller =
        PageController(initialPage: widget.poglavljaKeys.indexOf(widget.title));

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              _title = widget.poglavljaKeys[value];
            });
          },
          controller: controller,
          itemCount: widget.poglavljaKeys.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: HtmlWidget(widget.poglavlja[_title])));
          }),
    );
  }
}
