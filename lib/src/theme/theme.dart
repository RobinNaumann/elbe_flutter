import '../../elbe.dart';

class ElbeThemeData extends JsonModel {
  final ColorThemeData color;
  final TypeThemeData type;
  final GeometryThemeData geometry;

  ElbeThemeData(
      {required this.color, required this.type, required this.geometry});

  ElbeThemeData.preset({
    ColorThemeData? color,
    TypeThemeData? type,
    GeometryThemeData? geometry,
  }) : this(
            color: color ?? ColorThemeData.preset(),
            type: type ?? TypeThemeData.preset(),
            geometry: geometry ?? GeometryThemeData.preset());

  get map => {
        'color': color.map,
        'type': type.map,
        'geometry': geometry.map,
      };

  ElbeThemeData copyWith({
    ColorThemeData? color,
    TypeThemeData? type,
    GeometryThemeData? geometry,
  }) {
    return ElbeThemeData(
        color: color ?? this.color,
        type: type ?? this.type,
        geometry: geometry ?? this.geometry);
  }

  ElbeThemeData withColorSelection({
    ColorContrasts? contrast,
    ColorModes? mode,
    ColorSchemes? scheme,
    ColorKinds? kind,
    ColorManners? manner,
    ColorStates? state,
  }) {
    return copyWith(
        color: color.withSelection(color.selection.copyWith(
            contrast: contrast,
            mode: mode,
            scheme: scheme,
            kind: kind,
            manner: manner,
            state: state)));
  }
}

extension ThemeContext on BuildContext {
  /// get the current elbe theme
  ElbeThemeData get theme => Theme.of(this);
}

class ElbeInherited<T extends JsonModel> extends InheritedTheme {
  final T data;
  final int _dataHashCode;

  ElbeInherited({
    Key? key,
    required this.data,
    required Widget child,
  })  : _dataHashCode = data.hashCode,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant ElbeInherited<T> oldWidget) =>
      oldWidget._dataHashCode != data.hashCode;

  @override
  Widget wrap(context, Widget child) =>
      ElbeInherited<T>(data: data, child: child);
}

class Theme extends StatelessWidget {
  final ElbeThemeData data;
  final Widget child;
  const Theme({super.key, required this.data, required this.child});

  static ElbeThemeData? maybeOf(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<ElbeInherited<ElbeThemeData>>();
    return theme?.data;
  }

  static ElbeThemeData of(BuildContext context) {
    final theme = maybeOf(context);
    if (theme == null) {
      throw FlutterError(
          'No ElbeThemeData found in context. Make sure to wrap your app with a Theme widget.');
    }
    return theme;
  }

  @override
  Widget build(BuildContext context) {
    return ElbeInherited<ElbeThemeData>(data: data, child: child);
  }
}
