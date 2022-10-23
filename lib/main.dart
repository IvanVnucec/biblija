import 'package:flutter/material.dart';

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
  State<HomePage> createState() => ListaKnjiga();
}

class ListaKnjiga extends State<HomePage> {
  List<Widget> dohvatiListuKnjiga() {
    return const [
      Knjiga(title: 'Knjiga 1'),
      Knjiga(title: 'Knjiga 2'),
      Knjiga(title: 'Knjiga 3'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listaKnjiga = dohvatiListuKnjiga();
    return Scaffold(
      appBar: AppBar(title: const Text("Knjige")),
      body: ListView(children: listaKnjiga),
    );
  }
}

class Knjiga extends StatelessWidget {
  final String title;

  const Knjiga({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => ListaPoglavlja(title: title))));
      },
    );
  }
}

class Poglavlje extends StatelessWidget {
  final String title;

  const Poglavlje({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => PregledPoglavlja(title: title))));
      },
    );
  }
}

class ListaPoglavlja extends StatelessWidget {
  final String title;

  const ListaPoglavlja({super.key, required this.title});

  List<Widget> dohvatiListuPoglavlja() {
    return const [
      Poglavlje(title: 'Poglavlje 1'),
      Poglavlje(title: 'Poglavlje 2'),
      Poglavlje(title: 'Poglavlje 3'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listaPoglavlja = dohvatiListuPoglavlja();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(children: listaPoglavlja),
    );
  }
}

class PregledPoglavlja extends StatelessWidget {
  final String title;

  const PregledPoglavlja({super.key, required this.title});

  Text dohvatiTekstPoglavlja() {
    return const Text("Text poglavlja");
  }

  @override
  Widget build(BuildContext context) {
    Text tekstPoglavlja = dohvatiTekstPoglavlja();

    return Scaffold(appBar: AppBar(title: Text(title)), body: tekstPoglavlja);
  }
}
