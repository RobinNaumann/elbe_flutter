import 'package:flutter/material.dart' as m;

import '../../../elbe.dart';

/// The main entry point for an Elbe app. It uses the [GoRouter] to manage
/// the routing and the [ThemeData] to manage the theme. The [ColorModes] is
/// used to manage the color mode.
class ElbeApp extends StatelessWidget {
  final bool debugShowMaterialGrid;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;

  //final GoRouter router;
  final List<ElbeRoute> routes;
  final String? initialRoute;
  final ElbeThemeData? theme;
  final ColorModes mode;
  final String name;
  const ElbeApp(
      {super.key,
      required this.routes,
      this.name = 'Elbe App',
      this.initialRoute,
      this.theme,
      this.mode = ColorModes.light,
      this.debugShowCheckedModeBanner = true,
      this.debugShowMaterialGrid = false,
      this.showPerformanceOverlay = false,
      this.checkerboardRasterCacheImages = false,
      this.checkerboardOffscreenLayers = false,
      this.showSemanticsDebugger = false});

  @override
  Widget build(BuildContext context) {
    final t = theme ?? ElbeThemeData.preset();
    final resTheme = m.ThemeData.from(
        useMaterial3: true, colorScheme: t.color.asMaterialTheme());
    return AppContext(
      name: name,
      menuOpen: false,
      layoutMode: AppLayoutMode.narrow,
      routes: routes,
      initialRoute: initialRoute,
      child: Theme(
          data: t,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Box(
                radius: 0,
                mode: mode,
                child: Stack(
                  children: [
                    Row(
                      gap: 0,
                      cross: CrossAxisAlignment.stretch,
                      children: [
                        AppMenuSpacer(),
                        Expanded(
                            child: _MatApp(
                                themeData: resTheme,
                                debugShowCheckedModeBanner:
                                    debugShowCheckedModeBanner))
                      ],
                    ),
                    AppMenu()
                  ],
                )),
          )),
    );
  }
}

class _MatApp extends m.StatelessWidget {
  final m.ThemeData themeData;
  final bool debugShowCheckedModeBanner;
  const _MatApp(
      {super.key,
      required this.themeData,
      required this.debugShowCheckedModeBanner});

  @override
  m.Widget build(m.BuildContext context) {
    return m.MaterialApp.router(
        theme: themeData,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        routerConfig: context.app.router.router);
  }
}
