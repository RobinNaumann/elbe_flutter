import 'package:elbe/elbe.dart';
import 'package:example/page/p_components.dart';
import 'package:example/page/p_home.dart';
import 'package:example/page/p_routing.dart';
import 'package:example/page/p_state.dart';
import 'package:example/page/p_theming.dart';
import 'package:example/page/p_utils.dart';

final appRoutes = <GoRoute>[
  GoRoute(path: '/', builder: (_, __) => const HomePage()),
  GoRoute(path: '/components', builder: (_, __) => const ComponentsPage()),
  GoRoute(path: '/theming', builder: (_, __) => const ThemingPage()),
  GoRoute(path: '/state', builder: (_, __) => const StatePage()),
  GoRoute(path: '/routing', builder: (_, __) => const RoutingPage()),
  GoRoute(path: '/utils', builder: (_, __) => const UtilsPage()),
];
