import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_service.dart';
import 'settings/settings_view.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(App(settingsController: settingsController));
}

class App extends StatelessWidget {
  final SettingsController settingsController;

  const App({super.key, required this.settingsController});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (context, child) {
        return MaterialApp(
          restorationScopeId: 'app',
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  default:
                    return HomePage(controller: settingsController);
                }
              },
            );
          },
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.controller});

  final String title = 'Biblija';
  final SettingsController controller;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<List<Knjiga>> dohvatiListuKnjiga(SettingsController controller) {
    return DefaultAssetBundle.of(context)
        .loadString('assets/bible.json')
        .then((jsonResponse) {
      List jsonObject = jsonDecode(jsonResponse);
      List<Knjiga> knjige = jsonObject
          .map((item) => Knjiga(
                title: item[0],
                poglavlja: item[1],
                controller: controller,
              ))
          .toList();
      return knjige;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Knjige"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Knjiga>>(
        future: dohvatiListuKnjiga(widget.controller),
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
  final SettingsController controller;

  const Knjiga(
      {super.key,
      required this.title,
      required this.poglavlja,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => ListaPoglavlja(
                title: title, poglavlja: poglavlja, controller: controller))));
      },
    );
  }
}

class Poglavlje extends StatelessWidget {
  final String title;
  final List poglavlja;
  final SettingsController controller;

  const Poglavlje(
      {super.key,
      required this.title,
      required this.poglavlja,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => PregledPoglavlja(
                  title: title,
                  poglavlja: poglavlja,
                  controller: controller,
                ))));
      },
    );
  }
}

class ListaPoglavlja extends StatelessWidget {
  final String title;
  final List poglavlja;
  final SettingsController controller;

  const ListaPoglavlja(
      {super.key,
      required this.title,
      required this.poglavlja,
      required this.controller});

  List<Poglavlje> dohvatiListuPoglavlja() {
    return poglavlja
        .map((item) => Poglavlje(
            title: item[0], poglavlja: poglavlja, controller: controller))
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
  final SettingsController controller;

  const PregledPoglavlja(
      {super.key,
      required this.title,
      required this.poglavlja,
      required this.controller});

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
                          fontSize: FontSize(widget.controller.fontSize),
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
