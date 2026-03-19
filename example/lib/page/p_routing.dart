import 'package:elbe/elbe.dart';

import '../bit/b_theme_seed.dart';

class RoutingPage extends StatelessWidget {
  const RoutingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Page(
      title: "routing",
      childrenMaxWidth: 40,
      actions: [
        ThemeSeedBit.builder(
            onData: (bit, data) => IconButton.plain(
                icon: data.mode.isDark ? Icons.moon : Icons.sun,
                onTap: bit.toggle))
      ],
      //leadingIcon: LeadingIcon.back(),
      children: [
        const Text(
            "elbe utilizes the 'go_router' package for routing. It is a simple and powerful routing package that allows for easy navigation and deep linking."),
        const Title.h6("define your routes"),
        Card(
            scheme: ColorSchemes.inverse,
            child: Text.code(
                """// it's recommended to define routes in a separate file for clarity
// routes.dart

final routes = [
  MenuRoute(
    path: '/components',
    label: 'Components',
    icon: Icons.layout,
    builder: (_) => const ComponentsPage()),
  ElbeRoute(path: '/theming', builder: (_) => const ThemingPage()),
];
"""
                    .trim())),
        const Title.h6("add routes to the app"),
        Card(
            scheme: ColorSchemes.inverse,
            child: Text.code("""
... 
ElbeApp(
  initialRoute: "/home",
  routes: appRoutes //<- add your routes here,
  ...
"""
                .trim())),
        const Title.h6("use the router"),
        Card(
            scheme: ColorSchemes.inverse,
            child: Text.code("""
context.app.router.push("/components"); // navigate to components page
"""
                .trim())),
      ],
    );
  }
}
