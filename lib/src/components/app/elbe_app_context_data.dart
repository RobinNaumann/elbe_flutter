part of 'elbe_app_context.dart';

class _ElbeRouterInterface extends JsonModel {
  final String? initialRoute;
  final List<ElbeRoute> routes;
  final GoRouter router;
  _ElbeRouterInterface(
      this.initialRoute, this.routes, void Function() onChanged)
      : router = GoRouter(
            initialLocation: initialRoute ?? routes.firstOrNull?.path ?? "/",
            routes: routes
                .map((e) => GoRoute(
                    path: e.path,
                    builder: (c, s) => e.builder(c),
                    pageBuilder: (context, state) =>
                        NoTransitionPage(child: e.builder(context))))
                .toList()) {
    router.routerDelegate.addListener(() => onChanged());
  }

  void _dispose() => router.dispose();

  String get path => router.routerDelegate.currentConfiguration.fullPath;

  void go(String path, {Map<String, dynamic>? args, bool replace = false}) {
    if (replace)
      router.replace(path, extra: args);
    else
      router.go(path, extra: args);
  }

  void goBack() {
    if (router.canPop()) router.pop();
  }

  bool get canGoBack => router.canPop();

  get map => {"path": path};
}

enum AppLayoutMode {
  mobile,
  narrow,
  wide;

  bool get isMobile => this == AppLayoutMode.mobile;
  bool get isNarrow => this == AppLayoutMode.narrow;
  bool get isWide => this == AppLayoutMode.wide;

  static AppLayoutMode fromView(FlutterView view) {
    final pxWidth = view.physicalSize.width / view.devicePixelRatio;
    if (pxWidth < 600) return AppLayoutMode.mobile;
    if (pxWidth < 1000) return AppLayoutMode.narrow;
    return AppLayoutMode.wide;
  }
}

class AppContextData extends JsonModel {
  final String name;
  final bool menuOpen;
  final AppLayoutMode layoutMode;
  late final _ElbeRouterInterface router;
  void Function({bool? menuOpen, String? name, AppLayoutMode? layoutMode})
      _onUpdated;

  AppContextData(this._onUpdated,
      {required this.menuOpen,
      required this.name,
      required this.layoutMode,
      required List<ElbeRoute> routes,
      String? initialRoute}) {
    router = _ElbeRouterInterface(initialRoute, routes, this.update);
  }

  AppContextData._copy(AppContextData other,
      {bool? menuOpen, String? name, AppLayoutMode? layoutMode})
      : name = name ?? other.name,
        menuOpen = menuOpen ?? other.menuOpen,
        layoutMode = layoutMode ?? other.layoutMode,
        _onUpdated = other._onUpdated,
        router = other.router;

  @override
  Map<String, dynamic> get map => {
        'name': name,
        'menuOpen': menuOpen,
        'layoutMode': layoutMode.name,
        'router': router.map,
      };

  void update({bool? menuOpen, String? name, AppLayoutMode? layoutMode}) =>
      _onUpdated.call(menuOpen: menuOpen, name: name, layoutMode: layoutMode);

  void dispose() => router._dispose();
}
