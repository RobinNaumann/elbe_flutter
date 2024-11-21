import 'package:flutter/material.dart' as m;

import '../../../../elbe.dart';
import '../../util/inherited_theme.dart';

export './colors/kind_color.dart';
export './colors/layer_color.dart';
export './colors/manner_color.dart';
export './colors/mode_color.dart';
export './colors/rich_color.dart';
export './colors/scheme_color.dart';
export './colors/state_color.dart';
export "alert_type.dart";
export "color_seed.dart";

/// a theme that provides colors for the app
class ColorTheme extends StatelessWidget {
  final ColorThemeData data;
  final Widget child;

  const ColorTheme({super.key, required this.data, required this.child});

  /// get the color theme data from the current context. this will throw an
  /// error if the context does not contain a color theme. use [maybeOf] if you
  /// want to handle the case where the context does not contain a color theme.
  static ColorThemeData of(BuildContext context) =>
      Theme.of<ColorThemeData>(context);

  /// get the color theme data from the current context. this will return null if
  /// the context does not contain a color theme. use [of] if you want to throw
  /// an error if the context does not contain a color theme.
  static ColorThemeData? maybeOf(BuildContext context) =>
      Theme.maybeOf<ColorThemeData>(context);

  @override
  Widget build(BuildContext context) {
    return ElbeInheritedTheme<ColorThemeData>(
        data: data,
        child: m.Theme(
            data: m.ThemeData(useMaterial3: true, colorScheme: data.asMaterial),
            child: child));
  }
}
