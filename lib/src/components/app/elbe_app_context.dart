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

  _ElbeRouterInterface _buildRouter() {
    final initialLoc =
        widget.initialRoute ?? widget.routes.firstOrNull?.path ?? "/";
    final router = GoRouter(
        initialLocation: initialLoc,
        routes: widget.routes
            .map((e) => GoRoute(
                path: e.path,
                builder: (c, s) => e.builder(c),
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: e.builder(context))))
            .toList());

    return _ElbeRouterInterface(widget.routes, router);
  }

  void _safeSetState(VoidCallback fn) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(fn);
    });
  }

  @override
  void initState() {
    super.initState();

    final elbeRouter = _buildRouter();
    // Listen to route changes to update the path in AppContextData
    elbeRouter.router.routerDelegate.addListener(() {
      _safeSetState(() {
        data = AppContextData._copy(data,
            router: _ElbeRouterInterface(widget.routes, elbeRouter.router));
      });
    });

    data = AppContextData(({layoutMode, name, menuOpen}) {
      _safeSetState(() {
        data = AppContextData._copy(data,
            menuOpen: menuOpen, name: name, layoutMode: layoutMode);
      });
    },
        router: elbeRouter,
        menuOpen: widget.menuOpen ?? false,
        name: widget.name ?? "Elbe App",
        layoutMode: widget.layoutMode ?? AppLayoutMode.narrow);

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
    data.router.router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElbeInherited<AppContextData>(
      data: data,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragStart: (details) {
          // Only trigger if drag starts near the left edge (e.g., < 24 logical pixels)
          if (details.globalPosition.dx < 24) {
            if (!data.menuOpen) {
              data.update(menuOpen: true);
            }
          }
        },
        child: widget.child,
      ),
    );
  }
}
