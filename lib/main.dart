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
      home: const MyHomePage(title: 'Biblija'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Knjige")),
      body: ListView(children: [
        _MyListTile(title: 'Knjiga 1', onTapWidget: _ListaPoglavlja(),),
        _MyListTile(title: 'Knjiga 2', onTapWidget: _ListaPoglavlja(),),
        _MyListTile(title: 'Knjiga 3', onTapWidget: _ListaPoglavlja(),),
      ]),
    );
  }
}

class _MyListTile extends StatelessWidget {
  final String title;
  final Widget onTapWidget;

  const _MyListTile({required this.title, required this.onTapWidget});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: ((context) => onTapWidget)));
      },
    );
  }
}

class _ListaPoglavlja extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Poglavlja")),
      body: ListView(children: [
        _MyListTile(title: 'Poglavlje 1', onTapWidget: _Poglavlje(),),
        _MyListTile(title: 'Poglavlje 2', onTapWidget: _Poglavlje(),),
        _MyListTile(title: 'Poglavlje 3', onTapWidget: _Poglavlje(),),
      ]),
    );
  }
}

class _Poglavlje extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Poglavlje")),
      body: const Text("Text poglavlja.")
    );
  }
}
