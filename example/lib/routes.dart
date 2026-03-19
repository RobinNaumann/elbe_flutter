import 'package:elbe/elbe.dart';
import 'package:example/page/p_components.dart';
import 'package:example/page/p_home.dart';
import 'package:example/page/p_routing.dart';
import 'package:example/page/p_state.dart';
import 'package:example/page/p_theming.dart';
import 'package:example/page/p_utils.dart';

final appRoutes = <ElbeRoute>[
  MenuRoute(
      path: '/home',
      label: 'Home',
      icon: Icons.home,
      builder: (_) => const HomePage()),
  MenuRoute(
      path: '/components',
      label: 'Components',
      icon: Icons.layout,
      builder: (_) => const ComponentsPage()),
  MenuRoute(
      path: '/theming',
      label: "Theming",
      icon: Icons.brush,
      builder: (_) => const ThemingPage()),
  MenuRoute(
      path: '/state',
      label: "State management",
      icon: Icons.activity,
      builder: (_) => const StatePage()),
  MenuRoute(
      path: '/routing',
      label: "Routing",
      icon: Icons.compass,
      builder: (_) => const RoutingPage()),
  MenuRoute(
      path: '/utils',
      label: "Utilities",
      icon: Icons.wrench,
      builder: (_) => const UtilsPage()),
  MenuRoute(
      path: "/about",
      label: "About",
      icon: Icons.info,
      bottom: true,
      builder: (_) => const Page(
            title: "About",
            child: Center(
              child: Text(
                "demo for the\nelbe flutter package",
                textAlign: TextAlign.center,
              ),
            ),
          ))
];
