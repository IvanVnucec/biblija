import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  State<HomePage> createState() => _ListaKnjiga();
}

class _ListaKnjiga extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Knjige")),
      body: ListView(children: const [
        _Knjiga(title: 'Knjiga 1'),
        _Knjiga(title: 'Knjiga 2'),
        _Knjiga(title: 'Knjiga 3'),
      ]),
    );
  }
}

class _Knjiga extends StatelessWidget {
  final String title;

  const _Knjiga({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => _ListaPoglavlja(title: title))));
      },
    );
  }
}

class _Poglavlje extends StatelessWidget {
  final String title;

  const _Poglavlje({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => _PregledPoglavlja(title: title))));
      },
    );
  }
}

class _ListaPoglavlja extends StatelessWidget {
  final String title;

  const _ListaPoglavlja({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(children: const [
        _Poglavlje(title: 'Poglavlje 1'),
        _Poglavlje(title: 'Poglavlje 2'),
        _Poglavlje(title: 'Poglavlje 3'),
      ]),
    );
  }
}

class _PregledPoglavlja extends StatelessWidget {
  final String title;

  const _PregledPoglavlja({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: const Text("Text poglavlja."));
  }
}
