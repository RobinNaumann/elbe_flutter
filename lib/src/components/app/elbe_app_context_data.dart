part of 'elbe_app_context.dart';

class _ElbeRouterInterface extends JsonModel {
  final List<ElbeRoute> routes;
  final GoRouter router;

  final String path;
  final bool canPop;

  _ElbeRouterInterface(this.routes, this.router)
      : path = router.routeInformationProvider.value.uri.toString(),
        canPop = router.canPop();

  void push(String path, {Map<String, dynamic>? args}) {
    router.push(path, extra: args);
  }

  void replace(String path,
      {Map<String, dynamic>? args, bool clearHistory = false}) {
    if (clearHistory) {
      router.go(path, extra: args);
    } else {
      router.pushReplacement(path, extra: args);
    }
  }

  void pop() {
    if (router.canPop()) router.pop();
  }

  get map => {
        "path": path,
        "canPop": canPop,
      };
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
  final _ElbeRouterInterface router;
  final void Function({bool? menuOpen, String? name, AppLayoutMode? layoutMode})
      _onUpdated;

  const AppContextData(this._onUpdated,
      {required this.menuOpen,
      required this.name,
      required this.layoutMode,
      required this.router});

  AppContextData._copy(AppContextData other,
      {bool? menuOpen,
      String? name,
      AppLayoutMode? layoutMode,
      _ElbeRouterInterface? router})
      : name = name ?? other.name,
        menuOpen = menuOpen ?? other.menuOpen,
        layoutMode = layoutMode ?? other.layoutMode,
        _onUpdated = other._onUpdated,
        router = router ?? other.router;

  @override
  Map<String, dynamic> get map => {
        'name': name,
        'menuOpen': menuOpen,
        'layoutMode': layoutMode.name,
        'router': router.map,
      };

  void update({bool? menuOpen, String? name, AppLayoutMode? layoutMode}) =>
      _onUpdated.call(menuOpen: menuOpen, name: name, layoutMode: layoutMode);
}
