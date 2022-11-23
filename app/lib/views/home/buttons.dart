import 'package:bible/components/elevated_rounded_button.dart';
import 'package:flutter/material.dart';

class HomePageSettingsButton extends ElevatedRoundedButton {
  HomePageSettingsButton({super.key})
      : super(
          iconData: Icons.settings,
          onPressed: () {},
        );
}

class HomePageBookmarkButton extends ElevatedRoundedButton {
  HomePageBookmarkButton({super.key})
      : super(
          iconData: Icons.bookmark,
          onPressed: () {},
        );
}

class HomePageLastReadButton extends ElevatedRoundedButton {
  HomePageLastReadButton({super.key})
      : super(
          iconData: Icons.restore,
          onPressed: () {},
        );
}

class HomePageSearchButton extends ElevatedRoundedButton {
  HomePageSearchButton({super.key})
      : super(
          iconData: Icons.search,
          onPressed: () {},
        );
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
