import 'package:elbe/elbe.dart';
import 'package:flutter/material.dart' as m;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const _items = [
    (icon: Icons.leaf, label: "components", route: "/components"),
    (icon: Icons.brush, label: "theming", route: "/theming"),
    (icon: Icons.activity, label: "state", route: "/state"),
    (icon: Icons.compass, label: "routing", route: "/routing"),
    (icon: Icons.wrench, label: "utilities", route: "/utils")
  ];

  @override
  Widget build(BuildContext context) => HeroScaffold(
        heroHeight: 14,
        leadingIcon: LeadingIcon.none(),
        title: 'elbe',
        hero: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.h1(
                "elbe",
                textAlign: TextAlign.center,
                resolvedStyle: TypeStyle(fontSize: 2.5),
              ),
              Text.bodyM("a humble Framework\nfor Flutter",
                  textAlign: TextAlign.center),
            ]),
        body: Padded.all(
          child: Center(
            child: Box.plain(
              constraints: RemConstraints(maxWidth: 51),
              child: Wrap(
                  runSpacing: context.rem(),
                  spacing: context.rem(),
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _PlatformIcon(name: "phone", icon: Icons.smartphone),
                          _PlatformIcon(name: "pc", icon: Icons.laptop),
                          _PlatformIcon(name: "web", icon: Icons.globe),
                        ].spaced()),
                    Spaced(),
                    Card(
                      scheme: ColorSchemes.secondary,
                      child: const Text(
                        "elbe is a minimalistic framework for Flutter.\n"
                        "It provides a set of widgets with a simplified styling system.\n"
                        "In addition, it provides a way to manage state (called 'bit'). This aims to separate the UI from the logic, while keeping a minimal API",
                        //textAlign: TextAlign.justify,
                      ),
                    ),
                    for (final e in _items)
                      Button.minor(
                        constraints:
                            const RemConstraints(minHeight: 3.5, maxWidth: 25),
                        icon: e.icon,
                        label: e.label,
                        onTap: e.route != null
                            ? () => context.push(e.route!)
                            : null,
                      ),
                    const Spaced(),
                    Button.action(
                        icon: Icons.github,
                        label: "repository",
                        onTap: () => launchUrlString(
                            "https://github.com/RobinNaumann/elbe_flutter")),
                    Button.action(
                        icon: Icons.globe,
                        label: "home page",
                        onTap: () => launchUrlString("https://robbb.in")),
                  ]),
            ),
          ),
        ),
      );
}

class _PlatformIcon extends StatelessWidget {
  final String name;
  final IconData icon;
  const _PlatformIcon({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) => m.Icon(icon);
}
