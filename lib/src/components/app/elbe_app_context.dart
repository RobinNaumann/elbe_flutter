import 'dart:ui';

import '../../../elbe.dart';

part 'elbe_app_context_data.dart';

extension AppBuildContextExt on BuildContext {
  AppContextData get app => AppContext.of(this);
}

class AppContext extends StatefulWidget {
  final Widget child;
  final bool? menuOpen;
  final String? name;
  final List<ElbeRoute> routes;
  final AppLayoutMode? layoutMode;
  final String? initialRoute;
  const AppContext(
      {super.key,
      required this.child,
      this.initialRoute,
      this.menuOpen,
      this.name,
      this.layoutMode,
      required this.routes});

  static AppContextData? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<ElbeInherited<AppContextData>>()
      ?.data;

  static AppContextData of(BuildContext context) {
    final theme = maybeOf(context);
    if (theme == null) {
      throw FlutterError('No AppContextData found in context. '
          'Make sure to wrap your app with an ElbeApp widget.');
    }
    return theme;
  }

  @override
  State<AppContext> createState() => _AppContextState();
}

class _AppContextState extends State<AppContext> {
  late AppContextData data;

  @override
  void initState() {
    super.initState();
    print("creating new AppContextData");
    data = AppContextData(({layoutMode, name, menuOpen}) {
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            print(
                "Updating AppContextData: menuOpen=$menuOpen, name=$name, layoutMode=$layoutMode");
            data = AppContextData._copy(data,
                menuOpen: menuOpen, name: name, layoutMode: layoutMode);
          });
        });
      }
    },
        initialRoute: widget.initialRoute,
        menuOpen: widget.menuOpen ?? false,
        name: widget.name ?? "Elbe App",
        layoutMode: widget.layoutMode ?? AppLayoutMode.narrow,
        routes: widget.routes);

    void onWidthChanged() {
      final view = View.maybeOf(context);
      if (view == null || !mounted) return;
      data.update(layoutMode: AppLayoutMode.fromView(view));
    }

    final called = WidgetsBinding.instance.platformDispatcher.onMetricsChanged;
    WidgetsBinding.instance.platformDispatcher.onMetricsChanged = () {
      called?.call();
      onWidthChanged();
    };

    WidgetsBinding.instance.addPostFrameCallback((_) => onWidthChanged());
  }

  @override
  void dispose() {
    data.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElbeInherited<AppContextData>(data: data, child: widget.child);
  }
}
