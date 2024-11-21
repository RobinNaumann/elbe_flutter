import 'package:flutter/material.dart' as m;

import '../../../elbe.dart';

/// The main entry point for an Elbe app. It uses the [GoRouter] to manage
/// the routing and the [ThemeData] to manage the theme. The [ColorModes] is
/// used to manage the color mode.
class ElbeApp extends StatelessWidget {
  final bool debugShowCheckedModeBanner;
  final GoRouter router;
  final ThemeData theme;
  final ColorModes mode;
  const ElbeApp(
      {super.key,
      required this.router,
      required this.theme,
      this.mode = ColorModes.light,
      this.debugShowCheckedModeBanner = true});

  @override
  Widget build(BuildContext context) {
    final resTheme = m.ThemeData.from(
        useMaterial3: true,
        colorScheme: theme.color.copyWith(mode: mode).asMaterial);
    return Theme(
        data: theme,
        child: Box.plain(
            mode: mode,
            child: m.MaterialApp.router(
                theme: resTheme,
                debugShowCheckedModeBanner: debugShowCheckedModeBanner,
                routerConfig: router)));
  }
}
