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
  ElbeRoute(path: '/theming', builder: (_) => const ThemingPage()),
  ElbeRoute(path: '/state', builder: (_) => const StatePage()),
  ElbeRoute(path: '/routing', builder: (_) => const RoutingPage()),
  ElbeRoute(path: '/utils', builder: (_) => const UtilsPage()),
];
