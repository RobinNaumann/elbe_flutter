import 'package:elbe/elbe.dart';

import '../bit/b_theme_seed.dart';

class RoutingPage extends StatelessWidget {
  const RoutingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      title: "routing",
      childrenMaxWidth: 40,
      actions: [
        ThemeSeedBit.builder(
            onData: (bit, data) => IconButton.flat(
                kind: ColorKinds.plain,
                icon: data.mode.isDark ? Icons.moon : Icons.sun,
                onTap: bit.toggle))
      ],
      //leadingIcon: LeadingIcon.back(),
      children: [
        const Text(
            "elbe utilizes the 'go_router' package for routing. It is a simple and powerful routing package that allows for easy navigation and deep linking."),
        const Title.h6("define the router"),
        Card(
            scheme: ColorSchemes.inverse,
            child: Text.code("""
final GoRouter _appRouter = GoRouter(routes: appRoutes);

// apply it to the app:
Widget build(BuildContext context) =>
  ElbeApp(
    router: _appRouter,
    ...
  );
"""
                .trim())),
        Title.h6("define routes"),
        Card(
            scheme: ColorSchemes.inverse,
            child: Text.code("""
// recommended to define routes in a separate file for clarity
// routes.dart

final appRoutes = <GoRoute>[
  GoRoute(path: '/', builder: (_, __) => const HomePage()),
  GoRoute(path: '/components', builder: (_, __) => ...),
  ...
];
"""
                .trim())),
        Title.h6("use the router"),
        Card(
            scheme: ColorSchemes.inverse,
            child: Text.code("""
context.push('/components');
"""
                .trim())),
      ],
    );
  }
}
