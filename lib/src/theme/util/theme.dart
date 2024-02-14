import '../../../elbe.dart';
import 'inherited_theme.dart';
import 'package:flutter/material.dart' as m;

class ThemeData {
  final ColorThemeData color;
  final TypeThemeData type;
  final GeometryThemeData geometry;

  const ThemeData(
      {required this.color, required this.type, required this.geometry});

  ThemeData.preset({Color color = Colors.purple})
      : this(
            color: ColorThemeData.fromColor(accent: color),
            type: TypeThemeData.preset(),
            geometry: GeometryThemeData.preset());

  factory ThemeData.fromContext(BuildContext context) => ThemeData(
      color: ColorTheme.of(context),
      type: TypeTheme.of(context),
      geometry: GeometryTheme.of(context));

  /// syntactic sugar for easier access to the remSize
  double? rem(double? dim) => geometry.maybeRem(dim);

  List<ElbeInheritedThemeData> get data => [color, type, geometry];
}

class Theme extends StatelessWidget {
  final ThemeData data;
  final Widget child;
  const Theme({super.key, required this.data, required this.child});

  static T of<T extends ElbeInheritedThemeData>(BuildContext context) {
    final d = maybeOf<T>(context);
    try {
      return d!;
    } catch (e) {
      throw Exception(
          "ElbeTheme: could not find a '${T.toString()}' in the given context");
    }
  }

  static T? maybeOf<T extends ElbeInheritedThemeData>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElbeInheritedTheme<T>>()?.data;

  @override
  Widget build(BuildContext context) =>
      data.data.reversed.fold(child, (p, e) => e.provider(p));
}
