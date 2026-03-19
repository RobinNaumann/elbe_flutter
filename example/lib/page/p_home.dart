import 'package:elbe/elbe.dart';
import 'package:example/view/v_theme_edit.dart';
import 'package:flutter/material.dart' as m;
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
        title: 'elbe',
        hero: Column(
            cross: CrossAxisAlignment.center,
            main: MainAxisAlignment.center,
            children: [
              const Text.h1(
                "elbe",
                textAlign: TextAlign.center,
                resolvedStyle: TypeStyle(fontSize: 2.5),
              ),
              const Text.bodyM("a humble Framework\nfor React and Flutter",
                  textAlign: TextAlign.center),
              Button.flat(
                  icon: Icons.externalLink,
                  label: "React demo",
                  onTap: () => launchUrlString("https://robbb.in/elbe")),
            ]),
        body: Padded.symmetric(
          vertical: 2,
          horizontal: 1,
          child: Center(
            child: Box(
              constraints: const RemConstraints(maxWidth: 40),
              child: Column(
                children: [
                  const Row(main: MainAxisAlignment.center, children: const [
                    _PlatformIcon(name: "phone", icon: Icons.smartphone),
                    _PlatformIcon(name: "pc", icon: Icons.laptop),
                    _PlatformIcon(name: "web", icon: Icons.globe),
                  ]),
                  Button.flat(
                      icon: Icons.package,
                      label: "install via pub.dev",
                      onTap: () =>
                          launchUrlString("https://pub.dev/packages/elbe")),
                  const Card(
                    scheme: ColorSchemes.secondary,
                    child: Column(
                      cross: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "elbe is a UI and state management framework for Flutter.\n"
                          "It provides a set of widgets with a simplified styling system.\n"
                          "In addition, it provides a way to manage state (called 'bit'). This aims to separate the UI from the logic while keeping a minimal API",
                          //textAlign: TextAlign.justify,
                        ),
                        ThemeEdit(),
                      ],
                    ),
                  ),
                  Wrap(
                      runSpacing: context.rem(),
                      spacing: context.rem(),
                      children: [
                        for (final e in _items)
                          Button.minor(
                              constraints: const RemConstraints(
                                  minHeight: 3.5, maxWidth: 25),
                              icon: e.icon,
                              label: e.label,
                              onTap: () => context.app.router.push(e.route)),
                      ]),
                  const Spacer.vertical(1),
                  Button.flat(
                      icon: Icons.github,
                      label: "repository",
                      onTap: () => launchUrlString(
                          "https://github.com/RobinNaumann/elbe_flutter")),
                  Button.flat(
                      icon: Icons.globe,
                      label: "home page",
                      onTap: () => launchUrlString("https://robbb.in")),
                ],
              ),
            ),
          ),
        ),
      );
}

class _PlatformIcon extends StatelessWidget {
  final String name;
  final IconData icon;
  const _PlatformIcon({required this.name, required this.icon});

  @override
  Widget build(BuildContext context) => m.Icon(icon);
}
