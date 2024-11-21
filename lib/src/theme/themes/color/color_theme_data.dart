import 'package:flutter/material.dart' as m;

import '../../../../elbe.dart';
import '../../util/inherited_theme.dart';

var _matCache = null;

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

  @override
  Widget provider(Widget child) => ColorTheme(data: this, child: child);

  m.ColorScheme _asMaterial() => m.ColorScheme.dark();

  /*m.ColorScheme(
      brightness: mode.isDark ? m.Brightness.dark : m.Brightness.light,
      primary: activeScheme.accent,
      onPrimary: activeScheme.accent.front,
      secondary: activeScheme.accent.safeMinor,
      onSecondary: activeScheme.accent.safeMinor.front,
      surface: activeLayer,
      onSurface: activeLayer.front,
      background: activeLayer,
      onBackground: activeLayer.front,
      error: activeScheme.error.safeMajor,
      onError: activeScheme.error.safeMajor.front);*/
}
