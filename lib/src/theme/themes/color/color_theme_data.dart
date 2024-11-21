import 'package:elbe/util/json_tools.dart';
import 'package:flutter/material.dart' as m;

import '../../../../elbe.dart';
import '../../util/inherited_theme.dart';

Map<int, m.ColorScheme> _matCache = {};

/// a theme that provides colors for the app
class ColorThemeData extends ElbeInheritedThemeData {
  final ColorModes mode;
  final ColorSchemes scheme;
  final ColorKinds kind;
  final ColorManners manner;
  final ColorStates state;

  /// the values of the color theme
  final ModeColor data;

  late final asMaterial = _asMaterial();

  LayerColor resolve(
          {ColorModes? mode,
          ColorSchemes? scheme,
          ColorKinds? kind,
          ColorManners? manner,
          ColorStates? state}) =>
      data
          .mode(mode ?? this.mode)
          .scheme(scheme ?? this.scheme)
          .kind(kind ?? this.kind)
          .manner(manner ?? this.manner)
          .state(state ?? this.state);

  /// get the currently active color scheme for the current context
  SchemeColor get activeScheme => data.mode(mode);

  /// get the currently active color kind for the current context
  KindColor get activeKind => activeScheme.scheme(scheme);

  /// get the currently active color manner for the current context
  MannerColor get activeManner => activeKind.kind(kind);

  /// get the currently active color state for the current context
  StateColor get activeState => activeManner.manner(manner);

  /// get the currently active layer color for the current context
  LayerColor get activeLayer => activeState.state(state);

  ColorThemeData(
      {required this.data,
      required this.mode,
      this.scheme = ColorSchemes.primary,
      this.kind = ColorKinds.plain,
      this.manner = ColorManners.major,
      this.state = ColorStates.neutral});

  ColorThemeData copyWith(
          {ModeColor? data,
          ColorModes? mode,
          ColorSchemes? scheme,
          ColorKinds? kind,
          ColorManners? manner,
          ColorStates? state}) =>
      ColorThemeData(
          data: data ?? this.data,
          mode: mode ?? this.mode,
          scheme: scheme ?? this.scheme,
          kind: kind ?? this.kind,
          manner: manner ?? this.manner,
          state: state ?? this.state);

  /// create a color theme from a seed. The seed is used to generate the colors
  factory ColorThemeData.fromSeed(ColorSeed seed,
          {ColorModes mode = ColorModes.light}) =>
      ColorThemeData(data: ModeColor.generate(seed), mode: mode);

  @override
  getProps() => [data, mode, scheme, kind, manner, state];

  JsonMap map() => {
        //"data": data.map,
        "mode": mode.name,
        "scheme": scheme.name,
        "kind": kind.name,
        "manner": manner.name,
        "state": state.name
      };

  int get _hash => map().hashCode;

  @override
  Widget provider(Widget child) => ColorTheme(data: this, child: child);

  m.ColorScheme _asMaterial() {
    return m.ColorScheme(
        brightness: mode.isDark ? m.Brightness.dark : m.Brightness.light,
        primary: activeScheme.accent.back,
        onPrimary: activeScheme.accent.front,
        secondary: activeScheme.accent.safeMinor.back,
        onSecondary: activeScheme.accent.safeMinor.front,
        surface: activeLayer.back,
        onSurface: activeLayer.front,
        error: activeScheme.error.safeMajor.back,
        onError: activeScheme.error.safeMajor.front);
  }
}
